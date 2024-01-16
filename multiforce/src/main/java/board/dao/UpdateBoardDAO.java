package board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import board.dto.updateBoardDTO;

@Repository
@Mapper
public interface UpdateBoardDAO {

    void insertUpdateBoard(updateBoardDTO dto);


    public List<updateBoardDTO> getAllUpdatePost(int project_seq);

}
