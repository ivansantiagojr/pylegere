# pylegere

A Python extension module to calculate the readability of your texts built with [PyOZ](https://github.com/pyozig/PyOZ).

`pylegere` consists of Python bindings for the [liblegere](https://github.com/ivansantiagojr/liblegere) implemented in Zig.

## Building

```bash
# Using PyOZ CLI (recommended)
pyoz build

# Or using Zig directly
zig build
```

## Development

```bash
# Install in development mode
pyoz develop

# Now you can import and test
python -c "import pylegere; print(pylegere.add(2, 3))"
```

## Building Wheels

```bash
# Build a wheel for distribution
pyoz build-wheel

# The wheel will be in dist/
```

## Usage

```python
import pylegere

# calculate the automated readability index
result = pylegere.ari("Hello, world!")
print(result)  # 4.0
```
