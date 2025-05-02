package com.web.spring.AttMng;



import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.Final.vo.Cal;



@Mapper
public interface CSDao {
	
	
	@Select("SELECT id, empno ,ename,start1 \"start\","
			+ "end1 \"end\", content FROM cal")
	List<Cal> CalList(); // 검색전 전테 출결 내역 출력

	@Select("select id, empno ,ename, start1 \"START\", end1 \"END\", content "
			+ "from cal "
			+ "where ename like #{ename} "
			+ "and content like #{content} "
			+ "and start1  BETWEEN #{start} and #{end}+1")
	List<Cal> CalList2(Cal sch);
	
	// empno를 통해 출결 상세 내역 찾기
//	@Select("SELECT id, empno, ename ,start1 \"START\",  end1 \"END\", content FROM cal WHERE id = #{id}")
//	Cal empnoByList(@Param("id")int id); 
	

	
	@Select("SELECT id, empno, ename ,start1+(9/24) \"start\","
			+ " end1 +(9/24) \"end\", content FROM cal WHERE id = #{id}")
	Cal empnoByList(@Param("id")int id); //(o)
	
	
	// 출결 내역 수정
//	@Update("UPDATE cal\r\n"
//			+ "	SET start1 = TO_DATE(#{start}, 'YYYY-MM-DD HH24:MI'),\r\n"
//			+ "	    end1 = TO_DATE(#{end}, 'YYYY-MM-DD HH24:MI'),\r\n"
//			+ "	    content = #{content},\r\n"
//			+ "	    ename = #{ename}\r\n"
//			+ "	WHERE id = #{id}")
//	int calUpdate(Cal calupt);
	
//	@Update("UPDATE cal "
//	        + "SET start1 = TO_DATE(#{start}, 'YYYY-MM-DD HH12:MI  AM'), "
//	        + "    end1 = TO_DATE(#{end}, 'YYYY-MM-DD HH12:MI  AM'), "
//	        + "    content = #{content}, "
//	        + "    ename = #{ename} "
//	        + "WHERE id = #{id}")
//	int calUpdate(Cal calupt);


	@Update("UPDATE cal "
		      + "SET start1 = #{start}, "
		      + "    end1 = #{end}, "
		      + "    content = #{content}, "
		      + "    ename = #{ename} "
		      + "WHERE id = #{id}")
	int calUpdate(Cal calupt);


	// 출결 내역 삭제
	@Delete("DELETE CAL WHERE ID = #{id}")
	int calDelete(Cal del);
	
	
	

	
	
	
	
}
