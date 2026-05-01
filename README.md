# zioease

> 30+ easing functions for Zig animation and tweening. Pure Zig, comptime generic over f32/f64.

Part of the [zio-zig](https://github.com/deblasis/zio-zig) ecosystem.

## Quick start

```zig
const ease = @import("zioease");

// Standard easing: pass a type and t ∈ [0, 1], get a value ∈ [0, 1]
const v1 = ease.linear(f32, 0.5);        // 0.5
const v2 = ease.quadIn(f32, 0.5);        // 0.25
const v3 = ease.bounceOut(f32, 0.5);     // ~0.765
const v4 = ease.elasticOut(f32, 0.5);    // ~1.089 (overshoots)

// Use with any float type
const v5 = ease.cubicInOut(f64, 0.25);
```

```bash
zig build test          # Run 37 tests
zig build run-example   # Run example
```

## API

All functions have the signature `fn(comptime T: type, t: T) T` where `t ∈ [0, 1]`.

### Linear
- `linear` — uniform speed

### Quadratic
- `quadIn`, `quadOut`, `quadInOut`

### Cubic
- `cubicIn`, `cubicOut`, `cubicInOut`

### Quartic
- `quartIn`, `quartOut`, `quartInOut`

### Quintic
- `quintIn`, `quintOut`, `quintInOut`

### Sine
- `sineIn`, `sineOut`, `sineInOut`

### Exponential
- `expoIn`, `expoOut`, `expoInOut`

### Circular
- `circIn`, `circOut`, `circInOut`

### Elastic (overshoots target)
- `elasticIn`, `elasticOut`, `elasticInOut`

### Back (pulls back before accelerating)
- `backIn`, `backOut`, `backInOut`

### Bounce (bounces at the end)
- `bounceIn`, `bounceOut`, `bounceInOut`

## License

MIT. Copyright (c) 2026 Alessandro De Blasis.
