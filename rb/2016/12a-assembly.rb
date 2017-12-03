# http://adventofcode.com/2016/day/12

@state = {
    a: 0,
    b: 0,
    c: 0,
    d: 0,
}

@pc = 0
@instrs = []

ARGF.each do |instruction|
    case instruction
    when /cpy (\d+) (\w)/
        @instrs << ->(a, b) {
            ->() { @state[b.to_sym] = a.to_i }
        }.($1, $2)
    when /cpy (\w) (\w)/
        @instrs << ->(a, b) {
            ->() { @state[b.to_sym] = @state[a.to_sym] }
        }.($1, $2)
    when /inc (\w)/
        @instrs << ->(a) {
            ->() { @state[a.to_sym] += 1 }
        }.($1)
    when /dec (\w)/
        @instrs << ->(a) {
            ->() { @state[a.to_sym] -= 1 }
        }.($1)
    when /jnz (\d+) (\d+)/
        @instrs << ->(a, b) {
            ->() {
                if a.to_i != 0
                    # -1 since we'll increment
                    @pc += b.to_i - 1
                end
            }
        }.($1, $2)
    when /jnz (\w) (-?\d+)/
        @instrs << ->(a, b) {
            ->() {
                if @state[a.to_sym] != 0
                    # -1 since we'll increment
                    @pc += b.to_i - 1
                end
            }
        }.($1, $2)
    end
end

while @pc < @instrs.count
    @instrs[@pc].()
    @pc += 1
end

puts @state[:a]
