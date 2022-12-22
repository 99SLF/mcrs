package com.zimax.mcrs.serialnumber.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.mapper.SerialnumberMapper;
import com.zimax.mcrs.serialnumber.pojo.Serialnumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


/**
 * @Author 施林丰
 * @Date:2022/12/19 15:33
 * @Description
 */
@Service
public class SerialnumberService {
    @Autowired
    SerialnumberMapper serialnumberMapper;

    /**
     * 新增编码规则
     * @param serialnumber 编码规则
     */
    public int addSerialnumber(Serialnumber serialnumber){
        int len = serialnumberMapper.count(null,serialnumber.getFunctionNum());
        if(len>0){
            return 1;
        }
        serialnumberMapper.addSerialnumber(serialnumber);
        return 0;
    }

    public void updateSerialnumber(Serialnumber serialnumber){
        serialnumberMapper.updateSerialnumber(serialnumber);
    }

    /**
     * s删除编码规则
     * @param Ids 编码规则主键
     */
    public void batchDeleteSerialnumber(List<Integer> Ids){
        serialnumberMapper.batchDeleteSerialnumber(Ids);
    }

    /**
     * 查询编码规则
     * @param page
     * @param limit
     * @param functionName
     * @param order
     * @param field
     * @return
     */
    public List<Serialnumber> querySerialnumbers(String page, String limit, String functionName,String functionNum, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "id");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("functionName", functionName);
        map.put("functionNum", functionNum);
        return serialnumberMapper.querySerialnumbers(map);
    }

    public int count(String functionName,String functionNum){
        return serialnumberMapper.count(functionName,functionNum);
    }


    /**
     * 根据编码规则编码获取编码规则流水号
     * @param functionNum
     * @return
     */
    public String getSerialNum(String functionNum){
        List<Serialnumber> SerialnumberList =
                this.querySerialnumbers("1","10",null,functionNum,null,null);
        if (SerialnumberList.size() < 1){
            return "无编码规则";
        }
        Serialnumber serialnumber = SerialnumberList.get(0);
        return this.getSerial(serialnumber.getTitleRule(), serialnumber.getNumBasis(), serialnumber.getNumberRule(),
                serialnumber.getFunctionNum(), serialnumber.getDigit(), serialnumber.getStartvalue());
    }


    private static final String FLOW_NAME_FLAG = "{F}";
    private static final String FLOW_SORT_FLAG = "{FS}";
    private static final String DEPART_NAME_FLAG = "{FS}";
    private static final String DEPART_SHORT_NAME_FLAG = "{SDN}";
    private static final String USER_NAME_FLAG = "{U}";
    private static final String ROLE_FLAG = "{R}";
    private static final String YEAR_FLAG = "{Y}";
    private static final String MONTH_FLAG = "{M}";
    private static final String DAY_FLAG = "{D}";
    private static final String HOUR_FLAG = "{H}";
    private static final String MINUTE_FLAG = "{I}";
    private static final String SECOND_FLAG = "{S}";
    private static final String NUMBER_FLAG = "{N}";


    public  String getSerial (String serialRule, String numBasis ,
                              String numberRule, String FunctionNum, long digitValue, long initialNumValue) {

        String serialTitle = serialRule;

        Calendar calendar = new GregorianCalendar();

        if (serialRule.indexOf(YEAR_FLAG) != -1) {
            int year = calendar.get(Calendar.YEAR);
            serialTitle = serialTitle.replace(YEAR_FLAG, String.valueOf(year));
        }

        if (serialRule.indexOf(MONTH_FLAG) != -1) {
            int month = calendar.get(Calendar.MONTH) + 1;
            String months = String.valueOf(month).length() == 2? String.valueOf(month) : "0"+String.valueOf(month);
            serialTitle = serialTitle
                    .replace(MONTH_FLAG, months);
        }

        if (serialRule.indexOf(DAY_FLAG) != -1) {
            int day = calendar.get(Calendar.DAY_OF_MONTH);
            String days = String.valueOf(day).length() == 2? String.valueOf(day) : "0"+String.valueOf(day);
            serialTitle = serialTitle.replace(DAY_FLAG, days);
        }

        if (serialRule.indexOf(HOUR_FLAG) != -1) {
            int hour = calendar.get(Calendar.HOUR_OF_DAY);
            serialTitle = serialTitle.replace(HOUR_FLAG, String.valueOf(hour));
        }

        if (serialRule.indexOf(MINUTE_FLAG) != -1) {
            int minute = calendar.get(Calendar.MINUTE);
            serialTitle = serialTitle.replace(MINUTE_FLAG,
                    String.valueOf(minute));
        }

        if (serialRule.indexOf(SECOND_FLAG) != -1) {
            int second = calendar.get(Calendar.SECOND);
            serialTitle = serialTitle.replace(SECOND_FLAG,
                    String.valueOf(second));
        }

        if (numberRule.indexOf(NUMBER_FLAG) != -1) {

            String ruleName = getRuleName(numBasis, FunctionNum);

            String serialNum = this.getSerialNum(ruleName, digitValue,
                    initialNumValue,FunctionNum);

            numberRule = numberRule.replace(NUMBER_FLAG,
                    String.valueOf(serialNum));
        }

        return serialTitle + numberRule;
    }

    /**
     * 获取流水单号
     * @param ruleName
     * @param digitValue
     * @param initialNumValue
     * @param functionNum
     * @return
     */
    public  String getSerialNum(String ruleName, long digitValue,
                                long initialNumValue, String functionNum) {

        Integer nextBigDecimal = 0;
        Serialnumber serialnumber_temp = new Serialnumber();
        serialnumber_temp.setRuleName(ruleName);

        List<Serialnumber> SerialnumberList =
                this.querySerialnumbers("1","10",null,functionNum,null,null);

        if (SerialnumberList.size() < 1) {
            serialnumber_temp.setDigit((int)digitValue);
            serialnumber_temp.setStartvalue((int)initialNumValue);
            serialnumber_temp.setCurrentvalue((int)initialNumValue);
            serialnumber_temp.setNote("first start");
            nextBigDecimal = (int)initialNumValue;
            this.addSerialnumber(serialnumber_temp);
        } else {
            Serialnumber serialnumber = SerialnumberList.get(0);

            if (serialnumber.getCurrentvalue() != null) {
                nextBigDecimal = serialnumber.getCurrentvalue() + 1;
            } else {
                nextBigDecimal = serialnumber.getStartvalue();
            }
            if (serialnumber.getRuleName() != null) {
                if (!serialnumber.getRuleName().equals(ruleName)) {
                    nextBigDecimal = serialnumber.getStartvalue();
                }
            }
            if (nextBigDecimal.toString().length() > digitValue) {
                nextBigDecimal = (int) initialNumValue;
                serialnumber.setNote("restart");
            }
            serialnumber.setCurrentvalue(nextBigDecimal);
            serialnumber.setRuleName(ruleName);
            this.updateSerialnumber(serialnumber);
        }

        String format = "%0" + digitValue + "d";

        String returnSerialNum = String.format(format,
                nextBigDecimal.longValue());

        return returnSerialNum;
    }


    /**
     * 规则过滤
     */
    private static String getRuleName(String numBasis, String flowName) {
        String ruleName = flowName;
        Calendar calendar = new GregorianCalendar();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        String months = String.valueOf(month).length() == 2? String.valueOf(month) : "0"+String.valueOf(month);
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        String days = String.valueOf(day).length() == 2? String.valueOf(day) : "0"+String.valueOf(day);
        if ("WFprocess".equals(numBasis)) {
            // 按流程
            ruleName = flowName;
        } else if ("WFprocess_year".equals(numBasis)) {
            // 按流程 + 年
            ruleName = flowName + "+" + String.valueOf(year);
        } else if ("WFprocess_year_month".equals(numBasis)) {
            // 按流程 + 年 + 月
            ruleName = flowName + "+" + String.valueOf(year) + "+"
                    + months;
        } else if ("WFprocess_year_month_day".equals(numBasis)) {
            // 按流程 + 年 + 月 + 日
            ruleName = flowName + "+" + String.valueOf(year) + "+"
                    + months + "+" + days;
        } else if ("WFprocess_depart".equals(numBasis)) {
            // 按部门

        } else if ("WFprocess_superDepart".equals(numBasis)) {
            // 按上一级部门

        } else {
            ruleName = flowName;
        }
        return ruleName;
    }


}
