package project.dao;

import java.util.List;

import project.dto.ProjectDTO;
import project.dto.ProjectDiscoverDTO;

public interface ProjectDiscoverDAO {

	List<ProjectDiscoverDTO> dicoverAllProjects(String query, String column, String ascOrDesc, int projectNumber, int start, int process);

	List<ProjectDiscoverDTO> discoverProjectsWithCategory(String query, String column, String ascOrDesc, int projectNumber,
			int start, int process, String category);

	int insertDummyProject(String startDate, String dueDate, int process, String url, String category, String title);

	Integer countAllProjects(String query);

	int countProjectsWithProcess(String query, int process);

	int countAllProjectsWithCategory(String query, String category);

	int countProjectsWithCategoryProcess(String query, int process, String category);

	List<ProjectDiscoverDTO> selectAllOngoingProject();

	

}
