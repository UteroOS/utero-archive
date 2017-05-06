# utero
![utero screenshot 2017-05-07 08-27](https://cloud.githubusercontent.com/assets/5820754/25776642/1111e0a0-32ff-11e7-9996-eb4e93755001.gif)

**Utero** is an operating system (for x86_64) written in [Crystal](https://crystal-lang.org/) *as much as possible*.

This is the *work in progress*.

## Requirements

* Crystal 0.22.0
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

To clean up
``$ make clean``

To test (crystal spec)
``$ make test``

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
