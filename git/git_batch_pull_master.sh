function pull_master() {
	project_dir=$1
	git_password=$2
	cd $project_dir
	git checkout master
	git pull origin master
}

function get_project_dirs() {
	dir=$1
	excludes=$2
	project_dirs=()
	for file in `ls $dir`
	do
		if [[ -d $dir"/"$file ]]; then
			if [[ ! " ${excludes[@]} " =~ " ${file} " ]]; then
    			project_dirs[${#project_dirs[@]}]=$file
			fi
		fi
	done
	echo ${project_dirs[*]}
}

function do_pull_all() {
	dir=$1
	git_password=$2
	project_dirs=$(echo "${@:3}")
	for project_dir in $project_dirs; do
		target_dir=$dir"\\"$project_dir
		
		echo "==> ready to handle project "$project_dir
		pull_master $target_dir $git_password
	done
}

# input arguments
path="D:\Projects"
excludes=("system", "myself", "candy", ".gradle")
git_password="???????"

# main execution
project_dirs=$(get_project_dirs $path $excludes)
projects=$(echo ${project_dirs[*]})
do_pull_all $path $git_password $projects
