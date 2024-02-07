package member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import member.dto.DeliveryDTO;


@Repository
@Mapper
public interface DeliveryDAO {

	//회원정보수정
	List<DeliveryDTO> getDelivery(int memberSeq);

	//회원정보수정 - 배송지추가
	int addressAdd(int memberSeq, String name, String phone, String postcode, String road, String jibun, 
						String extra, String detail, String requeste, boolean defaultAddress);

	//회원정보수정 - 추가한 배송지 삭제
	int addressAddDelete(int memberSeq, String name, String phone, String postcode, String road, String jibun,
			String extra, String detail);

	//회원정보수정 - 기존 배송지 삭제
	int addressDelete(int memberSeq, String name, String phone, String postcode, String road, String detail);

	//회원정보수정 - 배송지 추가 - 기본배송지 업데이트
	int allDefaultFalse(int memberSeq);



}
