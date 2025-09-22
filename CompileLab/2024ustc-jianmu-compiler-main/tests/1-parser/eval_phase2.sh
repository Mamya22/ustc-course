#!/bin/bash

# DO NOT MODIFY!
# If you need customized behavior, please create your own script.

function run_tests() {
    local TESTCASE_DIR=$1
    local OUTPUT_DIR=$2
    local OUTPUT_STD_DIR=$3
    local score=0
    local total=0

    mkdir -p "$OUTPUT_DIR"

    # 对每个 .cminus 文件生成 ast 文件
    for testcase in "$TESTCASE_DIR"/*.cminus; do
        filename="$(basename "$testcase")"

        # 检查文件名是否以 FAIL 开头，跳过该文件
        if [[ "$filename" == FAIL* ]]; then
            echo "[info] Skipping $filename (starts with FAIL)"
            continue
        fi

        echo "[info] Analyzing $filename"
        
        # 生成学生的 AST 文件
        "$BUILD_DIR"/cminusfc -emit-ast "$testcase" > "$OUTPUT_DIR/${filename%.cminus}.ast"
        
        # 比较当前文件的输出与标准输出
        if [[ ${2:-no} != "no" ]]; then
            echo "[info] Comparing $filename..."
            
            # 如果是详细模式
            if [[ ${2:-no} == "verbose" ]]; then
                diff "$OUTPUT_DIR/${filename%.cminus}.ast" "$OUTPUT_STD_DIR/${filename%.cminus}.ast"
            else
                diff -q "$OUTPUT_DIR/${filename%.cminus}.ast" "$OUTPUT_STD_DIR/${filename%.cminus}.ast"
            fi

            # 检查 diff 的返回值
            if [ $? -eq 0 ]; then
                echo "[info] $filename is correct!"
                let score=score+1   # 正确时得分+1
            else
                echo "[info] $filename differs from the expected output."
            fi
        fi

        let total=total+1  # 总文件数+1

        rm -f "$CUR_DIR/${filename%.cminus}"
    done

    # 输出当前测试集的得分
    echo "[info] Score for $TESTCASE_DIR: $score/$total"
    return $score
}

# 检查命令行参数是否足够
if [[ $# -lt 1 ]]; then
    echo "usage: ./eval_phase2.sh   <input> [<summary>]"
    echo "       <input> can be one of 'easy', 'normal', 'hard', 'testcases_general', or '-all'."
    echo "       <summary> can be one of 'no', 'yes', and 'verbose'. the default value is 'no'"
    exit 1
fi

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BUILD_DIR="$CUR_DIR/../../build"

# 检查是否使用了 -all 选项
if [[ $1 == "-all" ]]; then
    TOTAL_SCORE=0
    TOTAL_FILES=0
    # 定义四个测试集
    TESTCASES=("easy" "normal" "hard" "testcases_general")

    for TESTCASE in "${TESTCASES[@]}"; do
        if [[ $TESTCASE == "testcases_general" ]]; then
            TESTCASE_DIR="$CUR_DIR/../$TESTCASE"
        else
            TESTCASE_DIR="$CUR_DIR/input/$TESTCASE"
        fi
        OUTPUT_DIR="$CUR_DIR/output_student_ast/$TESTCASE"
        OUTPUT_STD_DIR="$CUR_DIR/output_standard_ast/$TESTCASE"

        # 计算有效文件数，跳过以 FAIL 开头的文件
        VALID_FILES=$(find "$TESTCASE_DIR" -maxdepth 1 -name '*.cminus' ! -name 'FAIL*' | wc -l)
        echo "[info] Found $VALID_FILES valid files in $TESTCASE_DIR"

        # 运行测试集并跳过以 FAIL 开头的文件
        run_tests "$TESTCASE_DIR" "$OUTPUT_DIR" "$OUTPUT_STD_DIR" $2
        CURRENT_SCORE=$?

        let TOTAL_SCORE+=CURRENT_SCORE
        TOTAL_FILES=$(($TOTAL_FILES + $VALID_FILES))
    done

    # 输出总分
    echo "[info] Total score for all testcases: $TOTAL_SCORE/$TOTAL_FILES"

else
    # 单个测试集处理
    TESTCASE="$1"
    if [[ $TESTCASE == "easy" || $TESTCASE == "normal" || $TESTCASE == "hard" ]]; then
        TESTCASE_DIR="$CUR_DIR/input/$TESTCASE"
    elif [[ $TESTCASE == "testcases_general" ]]; then
        TESTCASE_DIR="$CUR_DIR/../$TESTCASE"
    fi

    OUTPUT_DIR="$CUR_DIR/output_student_ast/$TESTCASE"
    OUTPUT_STD_DIR="$CUR_DIR/output_standard_ast/$TESTCASE"

    # 运行单个测试集
    run_tests "$TESTCASE_DIR" "$OUTPUT_DIR" "$OUTPUT_STD_DIR" $2
fi