const std = @import("std");
const builtin = @import("builtin");
const warn = std.debug.warn;

const C = @cImport({
    @cInclude("stdlib.h");
});

const PixelIndex: type = u32;
const width: PixelIndex = 12;
const height: PixelIndex = 12;
var RNG = std.rand.DefaultPrng.init(0);

const GameError = error{GameOver};

pub const Location = struct {
    row: PixelIndex,
    column: PixelIndex,

    pub fn random() Location {
        return Location{
            .row = RNG.random.intRangeLessThan(PixelIndex, 0, height),
            .column = RNG.random.intRangeLessThan(PixelIndex, 0, width),
        };
    }
};

const Direction = enum {
    Down,
    Up,
    Left,
    Right,

    pub fn parallel(a: Direction, b: Direction) bool {
        return switch (a) {
            .Down, .Up => b == .Up or b == .Down,
            .Left, .Right => b == .Left or b == .Right,
        };
    }
};

const Tile = enum {
    Open,
    SnakeBody,
    SnakeHead,
    Food,
};

const Tiles = [width][height]Tile;

const Board = struct {
    tiles: Tiles,

    pub fn init() Board {
        var self: Board = Board{ .tiles = undefined };
        self.clear();
        return self;
    }

    pub fn clear(self: *Board) void {
        for (self.tiles) |row, row_number| {
            for (row) |tile, column_number| {
                self.tiles[column_number][row_number] = .Open;
            }
        }
    }
};

pub const SnakeSegment = struct {
    cranial: ?*SnakeSegment,
    caudal: ?*SnakeSegment,
    location: Location,

    pub fn init(allocator: *std.mem.Allocator) !*SnakeSegment {
        // Caller is responsible for destroying the segment that is returned
        var segment: *SnakeSegment = try allocator.create(SnakeSegment);
        segment.cranial = null;
        segment.caudal = null;
        segment.location = Location{
            .row = 0,
            .column = 0,
        };
        return segment;
    }
};

const Snake = struct {
    head: *SnakeSegment,
    tail: ?*SnakeSegment,
    direction: Direction,
    allocator: *std.mem.Allocator,

    pub fn init(allocator: *std.mem.Allocator) !Snake {
        var head: *SnakeSegment = try SnakeSegment.init(allocator);

        head.location = Location.random();

        return Snake{
            .head = head,
            .tail = null,
            .allocator = allocator,
            .direction = .Right,
        };
    }

    pub fn extend(self: *Snake, direction: Direction) !void {
        // Find out where the new head should move
        var new_head_location: Location = self.getNewHeadLocation(direction);
        try self.getNewHead(new_head_location);
        self.direction = direction;
    }

    fn getNewHeadLocation(self: *Snake, direction: Direction) Location {
        const old_head_location: Location = self.head.location;
        switch (direction) {
            .Up => {
                if (old_head_location.row == 0) {
                    return Location{ .row = height - 1, .column = old_head_location.column };
                } else {
                    return Location{ .row = old_head_location.row - 1, .column = old_head_location.column };
                }
            },
            .Down => {
                return Location{ .row = @mod(old_head_location.row + 1, height), .column = old_head_location.column };
            },
            .Left => {
                if (old_head_location.column == 0) {
                    return Location{ .row = old_head_location.row, .column = width - 1 };
                } else {
                    return Location{ .row = old_head_location.row, .column = old_head_location.column - 1 };
                }
            },
            .Right => {
                return Location{ .row = old_head_location.row, .column = @mod(old_head_location.column + 1, height) };
            },
        }
    }

    fn getNewHead(self: *Snake, location: Location) !void {
        var old_len = self.len();
        var new_head: *SnakeSegment = try SnakeSegment.init(self.allocator);
        new_head.location = location;
        new_head.caudal = self.head;
        self.head.cranial = new_head;
        self.head = new_head;
        if (self.tail == null) {
            self.tail = self.head.caudal;
        }

        std.debug.assert(self.len() == old_len + 1);
    }

    pub fn shrinkTail(self: *Snake) void {
        var old_len = self.len();

        self.updateTail((self.tail orelse unreachable).cranial orelse unreachable);
        (self.tail orelse unreachable).caudal = null;

        std.debug.assert(self.len() == old_len - 1);
    }

    pub fn updateTail(self: *Snake, segment: *SnakeSegment) void {
        self.tail = segment;
    }

    pub fn updateBoard(self: *Snake, board: *Board) void {
        var segment: *SnakeSegment = self.head;
        iteration: while (true) {
            segment = segment.caudal orelse break :iteration;
            const location: Location = segment.location;
            board.tiles[location.column][location.row] = .SnakeBody;
        }
    }

    pub fn len(self: *Snake) usize {
        var segment: *SnakeSegment = self.head;
        var result: usize = 0;
        while (true) {
            result += 1;
            segment = segment.caudal orelse return result;
        }
    }

    pub fn print(self: *Snake) void {
        warn("Snake(head: ({}, {}), len: {}, direction: {}, locations:\n", self.head.location.row, self.head.location.column, self.len(), self.direction);
        warn("    {} <-- head", self.head.location);
        var segment: *SnakeSegment = self.head;
        var result: usize = 0;
        iteration: while (true) {
            segment = segment.caudal orelse break :iteration;
            warn("\n    {}", segment.location);
        }
        warn(" <-- tail\n");
    }
};

const GameState = struct {
    board: Board,
    snake: Snake,
    allocator: *std.mem.Allocator,
    renderer: ?*Renderer,
    food_location: Location,
    keypress: Direction,

    pub fn init(allocator: *std.mem.Allocator) !GameState {
        return GameState{
            .board = Board.init(),
            .snake = try Snake.init(allocator),
            .allocator = allocator,
            .renderer = null,
            .food_location = Location.random(),
            .keypress = .Right,
        };
    }

    fn runGameLoop(self: *GameState, framerate: u32) !void {
        while (true) {
            std.time.sleep(@divTrunc(1000000000, framerate));
            try self.moveSnake(self.keypress);
        }
    }

    fn moveSnake(self: *GameState, direction: Direction) !void {
        var old_tail_location: ?Location = null;
        if (self.snake.tail) |tail| {
            old_tail_location = self.snake.head.location;
        }

        try self.snake.extend(direction);

        const new_head_location: Location = self.snake.head.location;
        var new_tail_location: ?Location = null;
        if (self.snake.tail) |tail| {
            new_tail_location = tail.location;
        }

        switch (self.board.tiles[new_head_location.column][new_head_location.row]) {
            .Open, .SnakeHead => {
                self.snake.shrinkTail();
            },
            .SnakeBody => return error.GameOver,
            .Food => {
                self.onFoodObtained();
            },
        }

        self.updateBoard();
        self.render();
    }

    pub fn updateBoard(self: *GameState) void {
        self.board.clear();
        self.board.tiles[self.food_location.column][self.food_location.row] = .Food;
        self.board.tiles[self.snake.head.location.column][self.snake.head.location.row] = .SnakeHead;
        self.snake.updateBoard(&self.board);
    }

    fn onFoodObtained(self: *GameState) void {
        self.food_location = Location.random();
    }

    pub fn render(self: *GameState) void {
        if (self.renderer) |renderer| {
            renderer.render(self);
        }
    }
};

const Renderer = struct {
    renderFn: fn (game: *GameState) void,
    pub fn render(self: *Renderer, game: *GameState) void {
        self.renderFn(game);
    }
};

pub fn clearScreen() void {
    _ = C.system(c"cls");
}

pub fn printGame(game: *GameState) void {
    clearScreen();

    warn("Snake\n");
    for (game.board.tiles) |row, row_number| {
        warn("+-");
        for (row) |tile, column_number| {
            warn("--");
        }
        warn("-+\n");
        break;
    }

    for (game.board.tiles) |row, row_number| {
        warn("| ");
        for (row) |tile, column_number| {
            switch (game.board.tiles[column_number][row_number]) {
                .Open => warn("  "),
                .SnakeBody => warn(" S"),
                .SnakeHead => warn(" H"),
                .Food => warn(" F"),
            }
        }
        warn(" |\n");
    }
    for (game.board.tiles) |row, row_number| {
        warn("+-");
        for (row) |tile, column_number| {
            warn("--");
        }
        warn("-+\n");
        warn("Control with WASD keys + Enter\n");
        warn("To exit, use Ctrl + C\n");
        break;
    }
}

pub fn main() void {
    gameExample() catch |err| {
        switch (err) {
            error.GameOver => {
                warn("You lose!\n");
            },
            error.OutOfMemory => {
                warn("Out of memory??\n");
            },
            else => {
                warn("Unexpected: {}\n", err);
            },
        }
        warn("Thanks for playing!\n");
    };
}

pub fn readInput(stream: var) !u8 {
    return try stream.readByte();
}

pub fn keyboardThread(state: *GameState) !void {
    var input = try std.io.getStdIn();
    var input_stream = input.inStream();

    while (true) {
        const key_code: u8 = try input_stream.stream.readByte();
        const keypress = switch (key_code) {
            119 => .Up, // W
            97 => .Left, // A
            115 => .Down, // S
            100 => .Right, // D
            else => state.keypress,
        };
        if (!Direction.parallel(state.keypress, keypress)) {
            state.keypress = keypress;
        }
    }
}

pub fn keyboardThreadWrapper(context: *GameState) void {
    keyboardThread(context) catch |err| {
        switch (err) {
            error.EndOfStream => return,
            else => warn("{} in keyboardThread\n", err),
        }
    };
}

pub fn gameExample() !void {
    warn("\nExample of a simple game (Snake). Press Enter to start.\n");

    var input = try std.io.getStdIn();
    var input_stream = input.inStream();
    _ = try input_stream.stream.readByte();

    // Memory allocation
    var arena: std.heap.ArenaAllocator = std.heap.ArenaAllocator.init(std.heap.direct_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    // Game logic management
    var state: GameState = try GameState.init(allocator);

    // Render to stderr
    var renderer: Renderer = Renderer{ .renderFn = printGame };
    state.renderer = &renderer;

    // Keyboard input
    var input_thread = try std.Thread.spawn(&state, keyboardThreadWrapper);

    // Game loop
    try state.runGameLoop(12);
}
