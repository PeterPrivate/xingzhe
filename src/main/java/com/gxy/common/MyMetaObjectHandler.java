package com.gxy.common;

import com.baomidou.mybatisplus.mapper.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;

import java.util.Date;

/**
 * Created by guanxy on 2017/11/21.
 */
public class MyMetaObjectHandler extends MetaObjectHandler {
    public void insertFill(MetaObject metaObject) {
        setFieldValByName("createTime",new Date(),metaObject);
    }

    public void updateFill(MetaObject metaObject) {
    }
}
