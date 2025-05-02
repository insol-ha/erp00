package com.web.spring.AttMng;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.Final.vo.Salary;

import jakarta.annotation.PostConstruct;

@Service
public class TaxService2 {

    private static final String EXCEL_FILE_PATH = "data(xlsx)/Tax.xlsx";
    
    
    @Autowired(required = false)
    private TaxDao dao;
    
    // 급여별 (부양가족 수 -> 근로소득세) 데이터를 저장하는 맵
    private final Map<Integer, Map<Integer, Integer>> taxCache = new HashMap<>();

    // 서버 시작 시 실행하여 데이터를 로드
    @PostConstruct
    public void loadTaxData() {
        try (FileInputStream fis = new FileInputStream(new File(EXCEL_FILE_PATH));
             Workbook workbook = new XSSFWorkbook(fis)) {

            Sheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {
                Cell salaryCell = row.getCell(0); // 급여
                if (salaryCell == null) continue;

                int salary = (int) getCellValueAsDouble(salaryCell);
                taxCache.putIfAbsent(salary, new HashMap<>());

                // 부양가족 수별 세금 데이터 읽기 (1~9명까지)
                for (int i = 1; i <= 9; i++) {
                    Cell taxCell = row.getCell(i + 1); 
                    // 컬럼 index 조정 (급여 컬럼 + 1 이후부터 부양가족별 세금 값)
                    if (taxCell != null) {
                        int tax = (int) getCellValueAsDouble(taxCell);
                        taxCache.get(salary).put(i, tax);
                    }
                }
            }
         
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 급여와 부양가족 수를 입력받아 근로소득세 반환
    public int calculateIncomeTax2(int salary, int dependents) {
        if (taxCache.containsKey(salary)) {
            return taxCache.get(salary).getOrDefault(dependents, -1); // 부양가족 수가 없으면 -1 반환
        }
        return -1; // 급여가 없으면 -1 반환
    }

    // 셀 값을 숫자로 변환하는 유틸리티 함수
    private double getCellValueAsDouble(Cell cell) {
        if (cell == null) return 0;
        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                try {
                    return Double.parseDouble(cell.getStringCellValue().replace(",", ""));
                } catch (NumberFormatException e) {
                    return 0;
                }
            default:
                return 0;
        }
    }
    
    public Salary salList(String ename) {
    	if (ename == null) {
	        ename = "";
	    }
	    return dao.salList(ename);
	}
    
    
}
