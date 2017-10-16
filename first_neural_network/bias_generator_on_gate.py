# Generate bias number depend on the weights assigned  and type of Logic Gate 

gate='OR' # Select gate type 'AND', 'NNAD', 'OR' and 'NOR'

# Assigned weights w1 and w1 
w1 = 1 
w2 = 1 

inputs = [[0,0],[1,0],[0,1],[1,1]]

gates = {'OR' :{'w': 1, 'b':-1 },
            'NOR' :  {'w': -1, 'b':1 },
            'AND' : {'w': 1, 'b':-1 },
            'NAND' : {'w': -1, 'b':1 } }


minimum  = min([w1,w2])
maximum  = max([w1,w2])
if gate == ('OR' or 'NOR' ):
    #return ('>0 or =<min', (min-0)/2)
    
    b= (minimum-0)/2
    print(gate + ' Gate :  >0 or =<min({}), bias = {}'.format(minimum, b))
else:
    #return ('>max or =<w1+w2', ((w1+w2)-max)/2)
    b= ((w1+w2+maximum))/2
    print(gate  + ' Gate  :  >max({}) or =<w1+w2({}) , bias = {}'. format(maximum, w1+w2, b ))
    
        
w1 = w1 * gates[gate]['w']
w2 = w2 * gates[gate]['w']
b =  b * gates[gate]['b']



print()
for x in inputs:
    m = ((x[0] * w1 + x[1] * w2)  + b)
    result = m >= 0.0
    print(result)
