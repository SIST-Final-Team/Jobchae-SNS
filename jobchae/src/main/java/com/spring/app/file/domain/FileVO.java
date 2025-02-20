package com.spring.app.file.domain;

public class FileVO {

	private String file_no; /* 게시물 첨부파일 일련번호 */
	private String file_target_no; /* 타겟 일련번호 */
	private String file_target_type; /* 타겟 유형 */
	private String file_name; /* 파일명 */
	private String file_original_name; /* 원본파일명 */
	private String file_size; /* 파일 크기 */
	private String file_register_date; /* 등록일자 */

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getFile_target_no() {
		return file_target_no;
	}

	public void setFile_target_no(String file_target_no) {
		this.file_target_no = file_target_no;
	}

	public String getFile_target_type() {
		return file_target_type;
	}

	public void setFile_target_type(String file_target_type) {
		this.file_target_type = file_target_type;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_original_name() {
		return file_original_name;
	}

	public void setFile_original_name(String file_original_name) {
		this.file_original_name = file_original_name;
	}

	public String getFile_size() {
		return file_size;
	}

	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}

	public String getFile_register_date() {
		return file_register_date;
	}

	public void setFile_register_date(String file_register_date) {
		this.file_register_date = file_register_date;
	}

}
