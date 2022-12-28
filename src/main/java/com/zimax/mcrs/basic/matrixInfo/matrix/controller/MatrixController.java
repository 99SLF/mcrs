package com.zimax.mcrs.basic.matrixInfo.matrix.controller;


import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.service.MatrixService;

import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/23 10:33
 */
@RestController
@ResponseBody
@RequestMapping("/MatrixController")
public class MatrixController {
    /**
     * 基地信息维护
     */
    @Autowired
    private MatrixService matrixService;


    /**
     * 基地信息维护
     *
     * @param matrix 基地信息
     */
    @PostMapping("/add")
    public Result<?> addMatrix(@RequestBody Matrix matrix) {

        matrixService.addMatrix(matrix);
        return Result.success();
    }

    /**
     * 更新基地信息
     *
     * @param matrix 基地维护信息
     * @return
     */
    @PostMapping("/update")
    public Result<?> updateMatrix(@RequestBody Matrix matrix) {
        matrixService.updateMatrix(matrix);
        return Result.success();
    }

     /**
     * 分页查询所有基地信息
     *
     * @param page          页记录数
     * @param limit         页码
     * @param infoId        树id
     * @param field         排序字段
     * @param order         排序方式
     * @return 数据列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryMatrix(String page, String limit, String infoId, String order, String field) {
        List Matrix = matrixService.queryMatrix(page, limit, infoId, order, field);
        return Result.success(Matrix, matrixService.count(infoId));
    }


    /**
     * 获取基地代码
     * @param
     * @return
     */
    @GetMapping("/selectMatrixCode")
    public Result<?> selectList(){
        Map<String,Object> maps = new HashMap<>();
        List<MatrixVo> matrixList = matrixService.selectList();//查询出数据
        maps.put("data",matrixList);
        return Result.success(matrixList, matrixService.countMatrix());
    }


    /**
     * 通过基地代码查询出相应的基地信息（名称）
     *
     * @param
     * @return
     */
    @GetMapping("/getMatrixName")
    public Result<?> getMatrixName(String matrixCode){
        List Matrix = matrixService.getMatrixName(matrixCode);
        return Result.success(Matrix);

    }



}
