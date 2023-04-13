package com.zimax.mcrs.log.service;

import com.alibaba.fastjson.JSON;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.mapper.LogFileMapper;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import com.zimax.mcrs.log.pojo.LogFile;
import com.zimax.mcrs.update.javaBean.UploadJava;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author 施林丰
 * @Date:2023/3/31 15:53
 * @Description
 */
@Service
public class LogFileService {
    @Autowired
    private LogFileMapper logFileMapper;
    private UploadJava uploadJava = (UploadJava) new ClassPathXmlApplicationContext(
            "applicationContext.xml").getBean("UploadJava");
    /**
     * 查询日志文件信息
     */
    public List<LogFile> queryLogFile(String limit, String page, String logType, String equipmentId, String logTime,  String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("logType", logType);
        map.put("equipmentId", equipmentId);
        map.put("logTime", logTime);
        return logFileMapper.queryLogFile(map);
    }

    /**
     * 查询记录
     */
    public int count(String logType, String equipmentId, String logTime) {
        return logFileMapper.count(logType,equipmentId,logTime);
    }
    public int addLogFile(String logType, String equipmentId, String logTime,String equipmentIp,int port) {
        HashMap map = new HashMap();
        String fileName = logTime.replace("-","_");
        map.put("code", "0");
        map.put("logType", logType);
        map.put("logTime", fileName);
        InputStream in = null;
        OutputStream out = null;
        BufferedWriter bufferedWriter = null;
        Socket socket = null;
        try {
            socket = new Socket();
            socket.connect(new InetSocketAddress(equipmentIp, port), 5000);

            bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            bufferedWriter.write(JSON.toJSONString(map));
            bufferedWriter.flush();
            socket.shutdownOutput();
            LogFile logFile = new LogFile();
            logFile.setEquipmentId(equipmentId);
            logFile.setLogType(logType);
            String uuid = String.valueOf(UUID.randomUUID());
            logFile.setFileUuid(uuid);
            logFile.setLogTime(logTime);
            logFile.setLogFileName(fileName+".txt");
            logFile.setFilePath(uploadJava.getLogFilePath()+File.separator+uuid+".txt");
            File dir = new File(uploadJava.getLogFilePath());
            if (!dir.exists()) {
                dir.mkdirs();
            }
            in = socket.getInputStream();
            //创建输出流存放读取的数据

            byte[] buff = new byte[1024];
            int len;
            if ((len = in.read(buff)) != -1) {
                out = new FileOutputStream(new File(logFile.getFilePath()));
                out.write(buff, 0, len);
            } else {
                return 1;
            }
            //io流读写数据
            while ((len = in.read(buff)) != -1) {
                out.write(buff, 0, len);
            }
            logFile.setCreateTime(new Date());
            logFileMapper.addLogFile(logFile);

        } catch (IOException e) {
            e.printStackTrace();
            return 2;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (in != null) {
                    in.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (out != null) {
                    out.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (bufferedWriter != null) {
                    bufferedWriter.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (socket != null) {
                    socket.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return  0;
    }
    public int  updateLogFile(LogFile logFile) {
        HashMap map = new HashMap();
        String fileName = logFile.getLogTime().replace("-","_");
        map.put("code", "0");
        map.put("logType", logFile.getLogType());
        map.put("logTime", fileName);
        InputStream in = null;
        OutputStream out = null;
        BufferedWriter bufferedWriter = null;
        Socket socket = null;
        try {
            socket = new Socket();
            socket.connect(new InetSocketAddress(logFile.getEquipmentIp(), logFile.getPort()), 5000);

            bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            bufferedWriter.write(JSON.toJSONString(map));
            bufferedWriter.flush();
            socket.shutdownOutput();
            File dir = new File(uploadJava.getLogFilePath());
            if (!dir.exists()) {
                dir.mkdirs();
            }
            in = socket.getInputStream();
            //创建输出流存放读取的数据

            byte[] buff = new byte[1024];
            int len;
            if ((len = in.read(buff)) != -1) {
                out = new FileOutputStream(new File(logFile.getFilePath()));
                out.write(buff, 0, len);
            } else {
                return 1;
            }
            //io流读写数据
            while ((len = in.read(buff)) != -1) {
                out.write(buff, 0, len);
            }
            logFile.setCreateTime(new Date());
            logFileMapper.updateLogFile(logFile);

        } catch (IOException e) {
            e.printStackTrace();
            return 2;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (in != null) {
                    in.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (out != null) {
                    out.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (bufferedWriter != null) {
                    bufferedWriter.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                if (socket != null) {
                    socket.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return  0;
    }

}
