package com.web.spring.AttMng;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.Final.vo.Att;
import com.web.spring.Final.vo.Cal;



@Mapper
public interface CalDao {

	
	@Select("SELECT id, ename, start1 \"START\", end1 \"END\", content, backgroundcolor,\r\n"
			+ "	textcolor, allday \r\n"
			+ "FROM cal")
	List<Cal> getCalList();
	
	@Select("SELECT id, ename, start1 AS \"START\", end1 AS \"END\", content, backgroundcolor, textcolor, allday "
	        + "FROM cal "
	        + "WHERE ename = #{ename}")
	List<Cal> enameCalList2(@Param("ename") String ename);

	
	// 기존 캘린더 등록 sql
//	@Insert("insert into cal values(calid_seq.nextval,#{ename},\r\n"
//			+ "	#{start},#{end},#{content},#{backgroundColor},#{textColor},\r\n"
//			+ "	#{allDay} )")
//	int insertCal(Cal ins); 
	
	// 연차 등록시 sql
	@Insert("INSERT INTO cal VALUES (calid_seq.NEXTVAL, #{ename}, " +
	        " CASE WHEN #{content} = '연차' THEN CAST(TRUNC(#{start}) + INTERVAL '9' HOUR AS DATE) "
	        + "ELSE #{start} END, " +
	        " CASE WHEN #{content} = '연차' THEN CAST(TRUNC(#{start}) + INTERVAL '18' HOUR AS DATE) "
	        + "ELSE #{end} END, " +
	        " #{content}, '#9ACD32', #{textColor}, #{allDay},#{empno} )")
	int insertCal(Cal ins);

	@Update("UPDATE cal\r\n"
			+ "	SET ename = #{ename},\r\n"
			+ "		start1 = #{start},\r\n"
			+ "		end1 = #{end},\r\n"
			+ "		content = #{content},\r\n"
			+ "		backgroundColor = #{backgroundColor},\r\n"
			+ "		textColor = #{textColor},\r\n"
			+ "		allDay = #{allDay}\r\n"
			+ "where id = 	#{id}")
	int updateCal(Cal upt);
	
	@Delete("delete from cal "
			+ " where id = #{id} ")
	int deleteCal(Cal del);
	
	// 데이터를 넣기 위한 *테스트용*
	// 클릭한 날짜에 현재 시각으로 등록됨 sysdate아니라 선택한 날짜의 현재시각
//	@Insert("insert into cal "
//			+ "values(calid_seq.nextval,#{ename},\r\n"
//			+" #{start} + (CURRENT_TIMESTAMP - TRUNC(CURRENT_TIMESTAMP)),"
//			+ "#{end},#{content},#{backgroundColor},#{textColor},\r\n"
//			+" #{allDay},null )")
//	int insStart(Cal insS);
	
	// 출근 한번만 찍을수 있게끔 날짜 비교해서 (시간무시)
	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} "
			+ "AND TRUNC(start1) = TRUNC(#{start})")
	int checkDuplicate(Cal insS);

	
//  어떤 날짜를 클릭해도 현재시각으로 등록되니 나중엔 이 sql 사용
	@Insert("insert into cal values(calid_seq.nextval,#{ename},\r\n"
	        +" sysdate,"
	        + "#{end}, #{content},#{backgroundColor},#{textColor},\r\n"
	        +" #{allDay},#{empno} )")
	int insStart(Cal insS);

	
	
	// sysdate로 퇴근시간 업데이트
//	@Update("update cal\r\n"
//			+ "	set end1 = sysdate \r\n"
//			+ "where id = #{id}")
//	int uptEnd(Cal uptE); // sysdate로 인해 오늘아닌 다른 날짜로 출/퇴근 찍을시 에러남

//	// 퇴근 한번만 찍을 수 있게끔
//	@Select("SELECT COUNT(*) FROM cal WHERE id = #{id} "
//			+ "AND TRUNC(end1) = TO_DATE(#{end})") // 퇴근 이미 찍은 날짜 같은지 비교
//	int checkDuplicate2(Cal uptE);
	
	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} "
			+ "AND TRUNC(start1) = TRUNC(SYSDATE) "
			+ "AND (content = '출근 중' OR content = '퇴근')")
	int checkBeforeUptEnd(@Param("ename") String ename);
	// 퇴근 찍기
	@Update("UPDATE cal SET end1 = SYSDATE, content = '퇴근' "
			+ "WHERE ename = #{ename} AND TRUNC(start1) = TRUNC(SYSDATE) ")
	int uptEnd(Cal uptE); // 오늘 날짜로 출근을 찍어야 퇴근 가능 아님 '퇴근 실패'

	
	// 퇴근 한번만 찍을 수 있게끔
//	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} "
//			+ "AND TRUNC(end1) = TRUNC(SYSDATE) ")  // end1이 이미 기록된 경우 체크
//	int checkDuplicate2(Cal uptE);
	
	
	// 연차 신청시 사용한 연차 개수 업데이트
	@Update("UPDATE att a\r\n"
			+ "SET a.usedpto = a.usedpto + 1\r\n"
			+ "WHERE ename = #{ename} and a.usedpto < a.pto")
	int uptUsed(Att upt);
	
	
	// 시차 1개 등록시 시간 저장하는 sql
	@Insert("insert into cal values(calid_seq.nextval,#{ename},\r\n"
			+" sysdate,  sysdate + INTERVAL '1' HOUR,#{content},'#ea2614',#{textColor},\r\n"
			+" #{allDay},#{empno} )")
	int insHour1(Cal insH);
	
	// 시차 1개 신청시 usedpto + 0.125	
	@Update("UPDATE att a\r\n"
			+ "SET a.usedpto = a.usedpto + 0.125\r\n"
			+ "WHERE ename = #{ename} and a.pto >= 0.125")
	int uptUsedH(Att uptU1);
	
	
	// 재택 등록시 bgc를 노랑색으로 설정
//	@Insert("INSERT INTO cal VALUES (calid_seq.NEXTVAL, #{ename}, " +
//	        " CASE WHEN #{content} = '재택' "
//	        + "THEN CAST(TRUNC(#{start}) + INTERVAL '9' HOUR ELSE #{start} END, " +
//	        " CASE WHEN #{content} = '재택' "
//	        + "THEN CAST(TRUNC(#{end})+ INTERVAL '18' HOUR ELSE #{end} END, " +
//	        " #{content}, '#e8bc0c', #{textColor}, #{allDay},null )")
//	int inswfh(Cal insW);
	

	// 재택 등록 sql
	@Insert("INSERT INTO cal VALUES (calid_seq.NEXTVAL, #{ename}, " +
	        " CASE WHEN #{content} = '재택' THEN TRUNC(#{start}) + INTERVAL '9' HOUR " +
	        " ELSE #{start} END, " +
	        " CASE WHEN #{content} = '재택' THEN TRUNC(#{start}) + INTERVAL '18' HOUR " +
	        " ELSE #{end} END, " +
	        " #{content}, '#e8bc0c', #{textColor}, #{allDay}, #{empno} )")
	int inswfh(Cal insW);

	// 재택 한달에 2번만 등록 가능하게끔 월단위로 비교
	@Select("SELECT COUNT(*) FROM cal "
			+ "WHERE ename = #{ename} "
			+ "AND content = '재택'"
			+ "AND TRUNC(start1, 'MM') = TRUNC(#{start}, 'MM')")
	int checkDuplicate3(Cal insW); // 재택 횟수 제한 가능(O)
	
	@Select("SELECT COUNT(*) FROM cal "
			+ "WHERE ename = #{ename} "
			+ "AND content = ''"
			+ "AND TRUNC(start1, 'DD') = TRUNC(#{start}, 'DD')")
	int checkInsert(Cal insW);
	
	
	// 재택 등록시 개수 감소
	@Update("UPDATE att a\r\n"
			+ "SET a.usedwfh = a.usedwfh + 1\r\n"
			+ "WHERE ename = #{ename} AND a.usedwfh < a.wfh")
	int uptUsedW(Att uptW);
	
	
	// 해당 날짜에 출근 기록이 있는지 확인하는 SQL
	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} " +
	        "AND TRUNC(start1) = TRUNC(#{start}) " + 
	        "AND content IN ('출근 중', '퇴근','재택')")
	int checkWorkRecord(Cal ins);

	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} " +
	        "AND TRUNC(start1) = TRUNC(#{start}) " + 
	        "AND content IN ('출근 중', '퇴근','연차')")
	int checkWorkRecord2(Cal insW);
	
	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} " +
	        "AND TRUNC(start1) = TRUNC(#{start}) " + 
	        "AND content = '재택'")
	int checkDuplicateWfh(Cal insW);
	
	@Select("SELECT COUNT(*) FROM cal WHERE ename = #{ename} " +
	        "AND TRUNC(start1) = TRUNC(#{start}) " + 
	        "AND content = '연차'")
	int checkDuplicatePto(Cal insW);
	
	// 로그인한 사원의 당일 출결 상태 
	@Select("SELECT content FROM cal \r\n"
			+ "WHERE ename =#{ename} \r\n"
			+ "AND trunc(start1) = trunc(sysdate)")
	String contentList(@Param("ename")String ename);
	
	
	
	
	
}
