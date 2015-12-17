wires = {}

def get_value(wires, value)
    if value =~ /\d+/
        value.to_i
    else
        wires[value].get()
    end
end

class Wire
    def initialize(fn)
        @fn = fn
        @cached = nil
    end

    def get
        if @cached.nil?
            @cached = @fn.()
        end

        @cached
    end
end

ASSIGN_REGEX = /(.+) -> (\w+)/
NOT_REGEX = /NOT (.+) -> (\w+)/
COMMAND_REGEX = /(.+) (\w+) (.+) -> (\w+)/

ARGF.each do |line|
    if line =~ COMMAND_REGEX
        a, command, b, slot = line.scan(COMMAND_REGEX)[0]

        case command
        when "AND"
            wires[slot] = Wire.new -> {
                get_value(wires, a) & get_value(wires, b)
            }
        when "OR"
            wires[slot] = Wire.new -> {
                get_value(wires, a) | get_value(wires, b)
            }
        when "LSHIFT"
            wires[slot] = Wire.new -> {
                get_value(wires, a) << get_value(wires, b)
            }
        when "RSHIFT"
            wires[slot] = Wire.new -> {
                get_value(wires, a) >> get_value(wires, b)
            }
        else
            puts "Hmmmm"
        end
    elsif line =~ NOT_REGEX
        value, slot = line.scan(NOT_REGEX)[0]

        wires[slot] = Wire.new -> {
            65535 - get_value(wires, value)
        }
    elsif line =~ ASSIGN_REGEX
        value, slot = line.scan(ASSIGN_REGEX)[0]

        wires[slot] = Wire.new -> {
            get_value(wires, value)
        }
    end
end

# Now, take the signal you got on wire a, override wire b to that signal,
# and reset the other wires (including wire a). What new signal is ultimately
# provided to wire a?
wires["b"] = Wire.new -> { 16076 }

puts wires["a"].get()
