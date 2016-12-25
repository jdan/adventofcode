# http://adventofcode.com/2016/day/10
#
# TODO(jordan): These globals should just be static variables for some class

state = {
    bots: Hash.new { |hash, key|
        hash[key] = { low: nil, high: nil }
    },
    outputs: Hash.new { |hash, key|
        hash[key] = { value: nil }
    },
}

listeners = {}

def give_to_bot(state, listeners, bot, value, reactive = false)
    bot_state = state[:bots][bot]

    if bot_state[:low] == nil && bot_state[:high] == nil
        bot_state[:low] = value
    elsif bot_state[:low] == nil
        if value > bot_state[:high]
            # swap em!
            bot_state[:low] = bot_state[:high]
            bot_state[:high] = value
        else
            bot_state[:low] = value
        end
    else
        if value < bot_state[:low]
            # swap em!
            bot_state[:high] = bot_state[:low]
            bot_state[:low] = value
        else
            bot_state[:high] = value
        end
    end

    if reactive && bot_state[:low] && bot_state[:high]
        listeners[bot].()
    end

    # This is where we check what the bot is comparing
    if bot_state[:low] == 17 && bot_state[:high] == 61
        puts "Bot #{bot} compares 17 and 61!"
        exit
    end

    state[:bots][bot] = bot_state
end

def give_to_output(state, output, value)
    state[:outputs][output] = value
end

def set_bot_listener(listeners, state, bot, low_type, low_dest, high_type, high_dest)
    listeners[bot] = ->() {
        bot_state = state[:bots][bot]

        if low_type == "output"
            give_to_output(state, low_dest, bot_state[:low])
        else
            give_to_bot(state, listeners, low_dest, bot_state[:low], true)
        end

        if high_type == "output"
            give_to_output(state, high_dest, bot_state[:high])
        else
            give_to_bot(state, listeners, high_dest, bot_state[:high], true)
        end
    }
end

def read_instruction(state, listeners, instruction)
    case instruction
    when /value (\d+) goes to bot (\d+)/
        give_to_bot(state, listeners, $2.to_i, $1.to_i)
    when /bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/
        set_bot_listener(listeners, state, $1.to_i, $2, $3.to_i, $4, $5.to_i)
    end
end

ARGF.each do |instruction|
    read_instruction(state, listeners, instruction)
end

listeners.keys.each do |bot|
    bot_state = state[:bots][bot]
    if bot_state[:low] && bot_state[:high]
        listeners[bot].()
    end
end
