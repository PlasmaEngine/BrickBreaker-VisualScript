InputAction
{
  string %Set{"BrickBreaker"}
  string %Action{"Left"}
  bool %TimeScale{false}
  float %FilterXMin{0}
  float %FilterXMax{0.34}
  float %FilterYMin{0.2}
  float %FilterYMax{1}
  Slot { string %Key{"keyboard_a"} float %Scale{1} }
  Slot { string %Key{"keyboard_left"} float %Scale{1} }
  Slot { string %Key{"touchpoint_0"} float %Scale{1} string %FilterX{"touchpoint_0_position_x"} string %FilterY{"touchpoint_0_position_y"} }
}

InputAction
{
  string %Set{"BrickBreaker"}
  string %Action{"Right"}
  bool %TimeScale{false}
  float %FilterXMin{0.66}
  float %FilterXMax{1}
  float %FilterYMin{0.2}
  float %FilterYMax{1}
  Slot { string %Key{"keyboard_d"} float %Scale{1} }
  Slot { string %Key{"keyboard_right"} float %Scale{1} }
  Slot { string %Key{"touchpoint_0"} float %Scale{1} string %FilterX{"touchpoint_0_position_x"} string %FilterY{"touchpoint_0_position_y"} }
}

InputAction
{
  string %Set{"BrickBreaker"}
  string %Action{"Launch"}
  bool %TimeScale{false}
  float %FilterXMin{0.34}
  float %FilterXMax{0.66}
  float %FilterYMin{0.2}
  float %FilterYMax{1}
  Slot { string %Key{"keyboard_space"} float %Scale{1} }
  Slot { string %Key{"mouse_button_0"} float %Scale{1} }
  Slot { string %Key{"touchpoint_0"} float %Scale{1} string %FilterX{"touchpoint_0_position_x"} string %FilterY{"touchpoint_0_position_y"} }
}

InputAction
{
  string %Set{"BrickBreaker"}
  string %Action{"Pause"}
  bool %TimeScale{false}
  Slot { string %Key{"keyboard_p"} float %Scale{1} }
  Slot { string %Key{"touchpoint_1"} float %Scale{1} }
}

InputAction
{
  string %Set{"BrickBreaker"}
  string %Action{"Restart"}
  bool %TimeScale{false}
  float %FilterYMin{0}
  float %FilterYMax{0.2}
  Slot { string %Key{"keyboard_r"} float %Scale{1} }
  Slot { string %Key{"touchpoint_0"} float %Scale{1} string %FilterY{"touchpoint_0_position_y"} }
  Slot { string %Key{"touchpoint_2"} float %Scale{1} }
}
