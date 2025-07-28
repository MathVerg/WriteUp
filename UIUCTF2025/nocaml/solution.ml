(*
external puts : string -> unit =  "puts";;
*)

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
  