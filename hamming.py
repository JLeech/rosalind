import itertools

def mutations(word, hamming_distance, charset='ATCG'):
    print("call ")
    for indices in itertools.combinations(range(len(word)), hamming_distance):
        print indices
        for replacements in itertools.product(charset, repeat=hamming_distance):
            print replacements
            mutation = list(word)
            for index, replacement in zip(indices, replacements):
                mutation[index] = replacement
            	print mutations


mutations("AAA",2, 'ATCG')