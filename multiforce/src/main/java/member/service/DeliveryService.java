package member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import member.dao.DeliveryDAO;
import member.dto.DeliveryDTO;


@Service
public class DeliveryService {
	
	@Autowired
	private DeliveryDAO deliveryDao;

	//회원정보수정
	public List<DeliveryDTO> getDelivery(int memberSeq) {
		return deliveryDao.getDelivery(memberSeq);
	}

	//회원정보수정 - 배송지추가
	public int addressAdd(int memberSeq, String name, String phone, String postcode, String road, String jibun, 
							String extra, String detail, String requeste,  boolean defaultAddress) {
		return deliveryDao.addressAdd(memberSeq, name, phone, postcode, road, jibun, extra, detail, requeste, defaultAddress);
	}

	//회원정보수정 - 추가한 배송지 삭제
	public int addressAddDelete(int memberSeq, String name, String phone, String postcode, String road, String jibun,
			String extra, String detail) {
		return deliveryDao.addressAddDelete(memberSeq, name, phone, postcode, road, jibun, extra, detail);
	}

	//회원정보수정 - 기존 배송지 삭제
	public int addressDelete(int memberSeq, String name, String phone, String postcode, String road, String detail) {
		return deliveryDao.addressDelete(memberSeq, name, phone, postcode, road, detail);
	}

	//회원정보수정 - 배송지 추가 - 기본배송지 업데이트
	public int allDefaultFalse(int memberSeq) {
		return deliveryDao.allDefaultFalse(memberSeq);		
	}


}
