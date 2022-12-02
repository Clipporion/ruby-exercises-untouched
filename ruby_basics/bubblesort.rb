def bubble_sort(array)
  ended = false

  while ended == false
    ended = true
    array.each_with_index do |item, index|
      if index < array.length-1
        if item > array[index+1]
          temp = array[index]
          array[index] = array[index+1]
          array[index+1] = temp
          ended = false
        end
      end
    end
  end
  puts array
end

bubble_sort([4,3,78,2,0,2])
