import sys

def sequence_cleaner(fasta_file, min_length=0, por_n=100):

    #create our hash table to add the sequences
    sequences = {}

    # Read the fasta input
    with open(fasta_file) as f: 
        for line in f:

            # Take the current ID and sequence
            if line[0] == '>':
                id_number = line
            else:
                sequence = line.upper()

                # Check if the current sequence is according to the user parameters
                if ( len(sequence) >= min_length and (float(sequence.count("N")) / float(len(sequence))) * 100 <= por_n ):

                   # hash table, the sequence and its id are going to be in the hash
                   if sequence not in sequences:
                       sequences[sequence] = id_number

                   # If it is already in the hash table, we're just gonna concatenate the ID
                   # of the current sequence to another one that is already in the hash table
                   else:
                       sequences[sequence] += "_" + id_number

    # Write the sequences to file
    # Create a file in the same directory where you ran this script
    with open("clear_" + fasta_file, "w+") as output_file:

        # Just read the hash table and write on the file as a fasta format
            for sequence in sequences:
                output_file.write(sequences[sequence] + sequence) 

    print("CLEAN!!!\nPlease check clear_" + fasta_file) 


userParameters = sys.argv[1:] 

try:
    if len(userParameters) == 1:
        sequence_cleaner(userParameters[0])
    elif len(userParameters) == 2:
        sequence_cleaner(userParameters[0],float(userParameters[1]))
    elif len(userParameters) == 3:
        sequence_cleaner(userParameters[0],float(userParameters[1]),float(userParameters[2]))
    else:
        print("There is a problem!")
except:
    print("There is a problem!")
