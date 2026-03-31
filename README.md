# pylegere

A Python extension module built with [PyOZ](https://github.com/pyozig/PyOZ).

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

# Add two numbers
result = pylegere.add(2, 3)
print(result)  # 5

# Multiply floats
result = pylegere.multiply(2.5, 4.0)
print(result)  # 10.0

# Get a greeting
print(pylegere.greet("World"))
```
