package com.web.spring.board;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.web.spring.board.VO.Board;
import com.web.spring.board.VO.BoardFile;
import com.web.spring.board.VO.BoardSch;
import com.web.spring.board.VO.ContentVO;

@Mapper
public interface Erp03_BoardDao {
	
	@Select("SELECT * FROM reply\r\n"
		         + "WHERE NO = #{no} order by rno ")
	List<ContentVO> getContentList(@Param("no") int no);	
			
/*	@Select("SELECT * FROM reply WHERE NO = #{no} order by rno ")
	List<ContentVO> getContentList(ContentVO sch);*/
	
	@Insert("INSERT INTO reply "
			+ "values(reply_seq.nextval, #{no}, #{contentComment}, sysdate)")
	int insContent(ContentVO ins);
	
	@Update("UPDATE reply \r\n"
			+ "SET no = #{no} ,\r\n"
			+ "	content = #{contentComment} ,\r\n"
			+ "	regdte = sysdate\r\n"
			+ "WHERE rno = #{rno}")
	int uptContent(ContentVO upt);

	@Delete("DELETE reply WHERE rno=#{rno}")
	int delContent(@Param("rno") int rno);
	
	
	
	@Select("SELECT count(*)\r\n"
			+ "	FROM board5 b\r\n"
			+ "	WHERE subject LIKE #{subject}\r\n"
			+ "	START WITH refno = 0		 	\r\n"
			+ "	CONNECT BY PRIOR NO = refno")
	int getBoardCount(BoardSch sch);
	
	@Select("SELECT * from(\r\n"
			+ "   SELECT rownum num, LEVEL, b.* \r\n"
			+ "   FROM board5 b\r\n"
			+ "   WHERE subject LIKE #{subject}\r\n"
			+ "   AND writer LIKE #{writer}\r\n"
			+ "   START WITH refno = 0         \r\n"
			+ "   CONNECT BY PRIOR NO = refno \r\n"
			+ "   ORDER siblings BY  NO desc\r\n"
			+ ")"
			+ "WHERE num BETWEEN #{start} AND #{end}")
	List<Board> getBoardList(BoardSch sch);
	
	@Insert("INSERT INTO board5 values(#{no},#{refno},#{subject} ,"
			+ "#{writer},#{content},#{readcnt},sysdate ,sysdate)")
	@SelectKey(statement="SELECT board5_seq.nextval  FROM dual", 
		keyProperty = "no", before=true, resultType=int.class)
	int insertBoard(Board ins);

	@Insert("INSERT INTO boardfile values(#{no}, "
			+ "#{fname},#{etc},sysdate,sysdate)")
	int insertBoardFile(BoardFile ins);	
	
	@Select("SELECT * FROM board5 WHERE NO = #{no}")
	Board getBoard(@Param("no") int no);
	
	@Select("SELECT fname FROM boardfile WHERE NO = #{no}")
	List<String> getBoardFile(@Param("no") int no);	


	@Update("UPDATE board5\r\n"
			+ "	SET readcnt = readcnt+1\r\n"
			+ "WHERE NO = #{no}")
	int readCntUpdate(@Param("no") int no);

   	@Update("UPDATE board5  SET refno = #{refno} ,\r\n"
   			+ "   			   	   subject = #{subject, jdbcType=VARCHAR} ,\r\n"
   			+ "   			 	   writer = #{writer},\r\n"
   			+ "   			 	   content = #{content},\r\n"
   			+ "   			  	   uptdte = sysdate\r\n"
   			+ "   			   	 WHERE NO = #{no}")
   	int updateBoard(Board upt);
   	
 
	@Delete("DELETE FROM board5\r\n"
			+ "    WHERE NO = #{no} ")
	int deleteBoard(@Param("no") int no);   	

	
	
}
