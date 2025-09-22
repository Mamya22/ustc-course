#!/bin/bash

project_dir=$(realpath ../../)
io_dir=$(realpath "$project_dir"/src/io)
output_dir=output
suffix=cminus
flag=""
LOG=log.txt

check_return_value() {
    rv=$1
    expected_rv=$2
    fail_msg=$3
    detail=$4
    if [ "$rv" -eq "$expected_rv" ]; then
        return 0
    else
        printf "\033[1;31m%s: \033[0m%s\n" "$fail_msg" "$detail"
        return 1
    fi
}

usage() {
	cat <<JIANMU
Usage: $0 [test-type]
test-type: 'licm' or 'mem2reg'
JIANMU
	exit 0
}

[ $# -lt 1 ] && usage
if [ "$1" == "licm" ]; then
    licm=true
    nflag="-mem2reg"
    flag="-mem2reg -licm"
elif [ "$1" == "mem2reg" ]; then
    licm=false
    nflag=""
    flag="-mem2reg"
else
    usage
fi

if [ $licm = true ]; then
    test_dir=./testcases/loop
else
    test_dir=./testcases/mem2reg
fi

testcases=$(ls "$test_dir"/*."$suffix" | sort -V)
check_return_value $? 0 "PATH" "unable to access to '$test_dir'" || exit 1

# hide stderr in the script
# exec 2>/dev/null

mkdir -p $output_dir

truncate -s 0 $LOG

echo "[info] Start testing, using testcase dir: $test_dir"
# asm
for case in $testcases; do
    echo "==========$case==========" >>$LOG
    case_base_name=$(basename -s .$suffix "$case")
    in_file=$test_dir/$case_base_name.in
    asm_mem2reg_on=$output_dir/${case_base_name}-$1-on.s
    asm_mem2reg_off=$output_dir/${case_base_name}-$1-off.s
    exe_mem2reg_on=$output_dir/${case_base_name}-$1-on
    exe_mem2reg_off=$output_dir/${case_base_name}-$1-off

    echo "==========$case=========="
    #### mem2reg off
    # cminusfc compile to .s
    bash -c "cminusfc -S $nflag $case -o $asm_mem2reg_off" >>$LOG 2>&1
    check_return_value $? 0 "CE" "cminusfc compiler error" || continue
    # gcc compile asm to executable
    loongarch64-unknown-linux-gnu-gcc -static \
        "$asm_mem2reg_off" "$io_dir"/io.c -o "$exe_mem2reg_off" \
        >>$LOG
    check_return_value $? 0 "CE" "gcc compiler error" || continue

    #### mem2reg on
    # cminusfc compile to .s
    bash -c "cminusfc -S $flag $case -o $asm_mem2reg_on" >>$LOG 2>&1
    check_return_value $? 0 "CE" "cminusfc compiler error" || continue
    # gcc compile asm to executable
    loongarch64-unknown-linux-gnu-gcc -static \
        "$asm_mem2reg_on" "$io_dir"/io.c -o "$exe_mem2reg_on" \
        >>$LOG
    check_return_value $? 0 "CE" "gcc compiler error" || continue

    echo "==========$1 off"
    if [ -e "$in_file" ]; then
        exec_cmd="qemu-loongarch64 $exe_mem2reg_off >/dev/null <$in_file"
    else
        exec_cmd="qemu-loongarch64 $exe_mem2reg_off >/dev/null"
    fi
    time bash -c "$exec_cmd"
    echo "==========$1 on"
    if [ -e "$in_file" ]; then
        exec_cmd="qemu-loongarch64 $exe_mem2reg_on >/dev/null <$in_file"
    else
        exec_cmd="qemu-loongarch64 $exe_mem2reg_on >/dev/null"
    fi
    time bash -c "$exec_cmd"

done
