import preproc_defined

if preproc_defined.call_checking() != 1:
    raise RuntimeError

d = preproc_defined.Defined()
d.defined = 10

preproc_defined.thing(10)
preproc_defined.stuff(10)
preproc_defined.bumpf(10)

if preproc_defined.a != 2:
    raise RuntimeError

if preproc_defined.b != 42:
    raise RuntimeError

if preproc_defined.z != 8:
    raise RuntimeError
