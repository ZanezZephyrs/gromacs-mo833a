
#valores default
number_of_runs=1
result_file=out.txt
type=release

while getopts n:r:t: flag
do
    case "${flag}" in
        n) number_of_runs=${OPTARG};;
        r) result_file=${OPTARG};;
        t) type=${OPTARG};;
    esac
done

cd gromacs_generated_files;
for i in $(seq $number_of_runs); do
    docker run -it --user=$(id -u):$(id -g) -v ${PWD}:${PWD} -w ${PWD} --rm gromacs_exp:$type gmx mdrun -v -deffnm em | grep MO833 | cut -d " " -f 5 >> ../$result_file;
done