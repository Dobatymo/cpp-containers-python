# Development

## Cython operator aliases

`cppcontainers/cppcontainers.pyx` imports Cython operators as `cy_deref`, `cy_dec`,
and `cy_inc` only to appease `cython-lint`.

The shadowing warning for these operator imports is a false positive. See
https://github.com/MarcoGorelli/cython-lint/issues/94.
