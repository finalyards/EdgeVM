# Decisions

Things considered, and the outcome.

This should help maintaining the repo.


## No need for `ASIF` format.

See: ["Consider using ASIF sparse disk images instead of RAW"](https://github.com/lima-vm/lima/issues/4323) (Nov, 2025)

>ASIF is better when storing the image on a volume that doesn't have native support for sparse files: it implements the sparse logic at the image layer. But when storing it on a filesystem like APFS, that has sparse file support, it has less than half the performance of using sparse files from the host filesystem itself.

We assume the macOS has APFS underlying. 

If you want, you can experiment with this. But the author keeps the provided YAML's with their default format (`raw`).
