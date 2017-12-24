# utero
<img src="doc/utero 2017-12-24.gif" alt="utero 2017-12-24">

**Utero** is an operating system (for x86_64) written in [Crystal](https://crystal-lang.org/) *as much as possible*.

This is the *work in progress*.

## Requirements

* Crystal 0.23.0
  * llvm
  * Please see [All required libraries](https://github.com/crystal-lang/crystal/wiki/All-required-libraries)
* nasm
* grub-mkrescue
* xorriso
* qemu-system-x86_64
* mformat (included in mtools)
  * optional, See more details http://os.phil-opp.com/multiboot-kernel.html#creating-the-iso

## Usage
To make an ISO file and run on Qemu

``$ make run``

To make an ISO file

``$ make iso``

To make a binary file of the kernel

``$ make`` or ``$ make all``

To compile the OS in DEBUG mode and run on Qemu

``$ make debug``

**Note:** in DEBUG mode, logging uses the serial port `COM1` to write various
debugging information. `qemu` is configured to write the output of this serial
port to `/tmp/serial.log`.

To clean up

``$ make clean``

### Troubleshooting on Qemu
On a system that uses EFI boot, like dual boot macOS and Ubuntu(16.04) on MacBook Pro

Error on Qemu like this

```sh
Could not read from CDROM (code 0009)
```

The solution may be:  

```sh
$ sudo apt-get install grub-pc-bin
```

After the install `grub-pc-bin`, you will need to recreate the ISO file like this:

```sh
$ make clean
$ make # or make iso
$ make run
```

The following links saved my life:

https://github.com/Microsoft/WSL/issues/1043

http://intermezzos.github.io/book/appendix/troubleshooting.html#Could%20not%20read%20from%20CDROM%20%28code%200009%29

## Contributing

1. Fork it ( https://github.com/UteroOS/utero/fork )
2. Clone it (including submodules)

  ```
  git clone --recursive <YOUR-FORKED-UTERO-URL>
  ```

  or

  ```
  git clone <YOUR-FORKED-UTERO-URL>
  git submodule update --init --recursive
  ```

3. Create your feature branch (git checkout -b my-new-feature)
4. Commit your changes (git commit -am 'Add some feature')
5. Push to the branch (git push origin my-new-feature)
6. Create a new Pull Request

## Contributors

- [noriyotcp](https://github.com/noriyotcp) Noriyo Akita - creator, maintainer, breeder of utero

## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any
additional terms or conditions.
