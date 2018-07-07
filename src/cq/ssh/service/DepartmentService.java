package cq.ssh.service;

import java.util.List;

import cq.ssh.dao.DepartmentDao;
import cq.ssh.entities.Department;

public class DepartmentService {
	private DepartmentDao departmentDao;
	public void setDepartmentDao(DepartmentDao departmentDao) {
		this.departmentDao = departmentDao;
	}
	public List<Department> getAll(){
		return departmentDao.getAll();
	}
}
