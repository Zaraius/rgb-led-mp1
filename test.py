pointer_idx = 0
bitstring = [1, 0, 0]
addbit = True
for i in range(8): # in reality needs to loop forever
    print(bitstring)
    if addbit:
        pointer_idx = (pointer_idx +1) % 3
        bitstring[pointer_idx] = 1
    else:
        bitstring[(pointer_idx+2)%3] = 0
    addbit = not addbit

# results in
# [1, 0, 0]
# [1, 1, 0]
# [0, 1, 0]
# [0, 1, 1]
# [0, 0, 1]
# [1, 0, 1]
# [1, 0, 0] (repeating)