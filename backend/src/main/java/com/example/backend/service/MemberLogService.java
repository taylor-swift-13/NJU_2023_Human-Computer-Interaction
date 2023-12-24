package com.example.backend.service;
import com.example.backend.common.Response;
import com.example.backend.entity.MemberLog;
import com.example.backend.mapper.MemberLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class MemberLogService {

    final MemberLogMapper memberLogMapper;
    @Autowired
    public MemberLogService(MemberLogMapper memberLogMapper) {
        this.memberLogMapper = memberLogMapper;
    }

    public Response insert(MemberLog memberLog) {
        memberLogMapper.insertMemberLog(memberLog);
        return Response.success();
    }


    public Response page() {
        List<MemberLog> memberLogList= memberLogMapper.page();
        Map<String, Object> map = new HashMap<>();
        map.put("data", memberLogList);
        return Response.success(map) ;
    }


}
