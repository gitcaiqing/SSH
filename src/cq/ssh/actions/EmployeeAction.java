package cq.ssh.actions;

import java.io.ByteArrayInputStream;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import cq.ssh.entities.Employee;
import cq.ssh.service.DepartmentService;
import cq.ssh.service.EmployeeService;

public class EmployeeAction extends ActionSupport implements RequestAware,
	ModelDriven<Employee>,Preparable{
	
	private static final long serialVersionUID = 1L;
	
	private EmployeeService employeeService;
	public void setEmployeeService(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}
	
	private DepartmentService departmentService;
	public void setDepartmentService(DepartmentService departmentService) {
		this.departmentService = departmentService;
	}
	
	/**
	 * 显示所有信息
	 * @return
	 */
	public String list(){
		request.put("employees", employeeService.getAll());
		return "list";
	}
	
	private Integer id;
	public void setId(Integer id) {
		this.id = id;
	}
	
	private InputStream inputStream;

	public InputStream getInputStream() {
		return inputStream;
	}
	
	public String delete(){
		//1常用方法
		/*employeeService.delete(id);
		return "success";*/
		
		//2.ajax
		try {
			employeeService.delete(id);
			inputStream = new ByteArrayInputStream("1".getBytes("UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
			try {
				inputStream = new ByteArrayInputStream("0".getBytes("UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
		
		return "ajax-success";
		
	}
	
	public String input(){
		System.out.println("departmentService.getAll():"+departmentService.getAll());
		
		request.put("departments", departmentService.getAll());
		
		
		return "input";
	}
	public String save(){
		//如果id为空则是新添加
		if(id == null){
			model.setCreateTime(new Date());
		}
		employeeService.saveOrUpdate(model);
		return "save-success";
	}
	
	
	
	
	private String lastName;
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public String validateLastName() throws UnsupportedEncodingException{
		System.out.println("ajax验证lastName---------->"+lastName);
		
		//如果数据库中无此lastName记录 返回值为1
		if(employeeService.lastNameIsValid(lastName)){
			inputStream = new ByteArrayInputStream("1".getBytes("UTF-8"));
		}else{
			inputStream = new ByteArrayInputStream("0".getBytes("UTF-8"));
		}
		
		//如果数据库中有此lastName记录 返回值为1
		return "ajax-success";
	}
	
	private Map<String, Object> request;
	@Override
	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}

	@Override
	public void prepare() throws Exception {
		
	}
	public void prepareSave(){
		if(id == null){
			model = new Employee();
		}else{
			model = employeeService.get(id);
		}
	}
	
	public void prepareInput(){
		System.out.println("id:"+id);
		if(id != null){
			model = employeeService.get(id);	
		}
		
	}
	private Employee model;
	@Override
	public Employee getModel() {
		
		return model;
	}
}
