# nocaml

- Author: [n8](https://farlow.dev/)
- Category: misc
- Final point value: 426
- Number of solves: 12

In this challenge, you can upload an OCaml source file to a server which will compile and run it. The server uses the following command on your input (in `code.ml`):

```sh
ocamlc -o "$tmp_dir/out" -open Nocaml "$tmp_dir/code.ml" && "$tmp_dir/out"
```

And the `Nocaml` module is compiled from the [`nocaml.ml`](./handouts/nocaml.ml) file, which redefines every function of the standard library as `unit` and every submodule as an empty structure (`struct end`).

So, we can not call any standard library function in our code. My first thought was that an OCaml binary must be linked against the C standard library, so there might be a way to call the C functions directly by their symbols. I found the following [documentation](https://ocaml.org/manual/5.3/intfc.html) explaining how to call C functions from OCaml. This requires declaring an OCaml function associated with the C function, using the following syntax:

```ocaml
external name : type = C-function-name
```

So, I can just create bindings for the `open`, `read` and `write` functions from the C standard library and call them from OCaml. To make sure these functions are actually linked in the binary, I fired GDB, but something unexpected happened:

```
"[]...]/nocaml/test/out": not in executable format: file format not recognized
```

And indeed, the compiled file is not an executable, but rather OCaml bytecode:

```sh
$ file out
out: a /usr/bin/ocamlrun script executable (binary data)
$ xxd out| head
00000000: 2321 2f75 7372 2f62 696e 2f6f 6361 6d6c  #!/usr/bin/ocaml
00000010: 7275 6e0a 5400 0000 df02 0000 0000 0000  run.T...........
00000020: 5700 0000 0100 0f00 1000 0000 1300 0000  W...............
00000030: 1c00 0000 2500 0000 2e00 0000 3700 0000  ....%.......7...
00000040: 4000 0000 4900 0000 5200 0000 5b00 0000  @...I...R...[...
00000050: 6700 0000 7400 0000 7d00 0000 8600 0000  g...t...}.......
00000060: 8f00 0000 9800 0000 6300 0000 2800 0000  ........c...(...
00000070: 0100 0000 0000 0000 4300 0000 0a00 0000  ........C.......
00000080: 3200 0000 2100 0000 3f00 0000 0000 0000  2...!...?.......
00000090: 2800 0000 0200 0000 0000 0000 4300 0000  (...........C...
```

This means that I can not call the C functions as I expected. However, right under the syntax of the `external` construct, we have an example of "how the `seek_in` primitive is declared in the standard library module `Stdlib`":

```ocaml
external seek_in : in_channel -> int -> unit = "caml_ml_seek_in"
```

It seems like what I thought to be just a feature of the language I might use for my purpose is actually the way the standard library is implemented: C functions with OCaml bindings over them. So, I just looked at how standard library functions are implemented ([here](https://github.com/ocaml/ocaml/blob/225eb4920294d56ef70d55220f705b5fa24d7ff0/stdlib/stdlib.ml)), and copied out the definitions I needed in my solution code. Here is my [solution](./solution.ml):

```ocaml
type out_channel
type in_channel

external set_in_channel_name: in_channel -> string -> unit =
  "caml_ml_set_channel_name"

external open_descriptor_out : int -> out_channel
                             = "caml_ml_open_descriptor_out"

external unsafe_output_string : out_channel -> string -> int -> int -> unit
                              = "caml_ml_output"

external open_descriptor_in : int -> in_channel = "caml_ml_open_descriptor_in"

type open_flag =
    Open_rdonly | Open_wronly | Open_append
  | Open_creat | Open_trunc | Open_excl
  | Open_binary | Open_text | Open_nonblock


external input_char : in_channel -> char = "caml_ml_input_char"

external open_desc : string -> open_flag list -> int -> int = "caml_sys_open"


let open_in_gen mode perm name =
  let c = open_descriptor_in(open_desc name mode perm) in
  set_in_channel_name c name;
  c

let open_in name =
  open_in_gen [Open_rdonly; Open_text] 0 name


external output_char : out_channel -> char -> unit = "caml_ml_output_char"


let () = 
  let stdout = open_descriptor_out 1 in
  let file = "flag.txt" in
  let ic = open_in file in
  while true do
    let c = input_char ic in
    output_char stdout c
  done
```

The solution is not very elegant, it prints the flag char by char until EOF, but doing something more subtle like reading the file into a buffer and printing it would have required copying more definitions from the standard library, and I am lazy ^^.

The challenge was fun, and made me looked at OCaml again after a few years, and have a glimpse at its internals. Thanks `n8`!