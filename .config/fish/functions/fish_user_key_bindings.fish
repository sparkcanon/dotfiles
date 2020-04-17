function fish_user_key_bindings
  fzf_key_bindings
  fish_vi_key_bindings
  bind --preset -M insert \ce edit_command_buffer
  bind --preset \ce edit_command_buffer
end
