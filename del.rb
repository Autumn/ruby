def occurences(a, b, i)
    marked = Hash.new
    count = 0
    while true
        found = false
        ip = i
        j = 0
        
        while true

            if a[ip] == b[j]
                if j == 1 and marked[ip] != true
                    marked[ip] = true
                    j += 1
                elsif j == 1 and marked[ip] == true
 
                else
                    j += 1
                end
            end          

            if j == b.length
                count += 1
                found = true
                break
            end
 
            if ip == a.length
                break
            end
            
            ip += 1

        end
  
        if found == false
            break
        end
    end 
    count
end

def del(a, b)
    count = 0
    a.length.times do |i|
        if a[i] == b[0]
            count += occurences(a, b, i)
        end
    end
    count
end


puts del("babab", "bab")
