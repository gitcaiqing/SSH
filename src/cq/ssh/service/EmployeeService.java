package cq.ssh.service;

import java.util.List;

import cq.ssh.dao.EmployeeDao;
import cq.ssh.entities.Employee;

public class EmployeeService {
	private EmployeeDao employeeDao;
	public void setEmployeeDao(EmployeeDao employeeDao) {
		this.employeeDao = employeeDao;
	}
	public List<Employee> getAll(){
		List<Employee> employees = employeeDao.getAll();
		return employees;
	}
	public void delete(Integer id){
		employeeDao.delete(id);
	}
	
	public void saveOrUpdate(Employee employee){
		employeeDao.saveOrUpdate(employee);
	}
	
	public boolean lastNameIsValid(String lastName){
		return employeeDao.getEmployeeByLastName(lastName) == null;
	}
	

	public Employee get(int id) {
		return employeeDao.get(id);
	}
	
}











