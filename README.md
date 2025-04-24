test mmkv with taskpool in harmonyos next.
1. `MMKV.initialize()` called very early
2. ui thread and task pool thread is in same process

![log](./screenshot/log.png)