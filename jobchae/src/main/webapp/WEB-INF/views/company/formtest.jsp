<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Form Test</title>
  </head>

  <!-- CONSTRAINT CK_tbl_company_size CHECK(company_size BETWEEN 1 AND 9),
   -- 1:직원 0-1명   
   -- 2:직원 2-10명
   -- 3:직원 11-50
   -- 4:직원 51-200
   -- 5:직원 201-500
   -- 6:직원 501-1000
   -- 7:직원 1001-5000
   -- 8:직원 5001-10000
   -- 9:직원 10000+ -->
  <body>
    <h1>Form Test Page</h1>
    <form action="#" method="post">
      <label for="name">Name :</label>
      <input
        type="text"
        id="name"
        name="name"
        required
        placeholder="단체 이름을 입력하세요"
      />
      <br />
      <label for="website">Website :</label>
      <input
        type="text"
        id="website"
        name="website"
        placeholder="http://www.example.com"
      />
      <br />
      <label for="industry">Industry :</label>
      <input type="text" id="industry" name="industry" placeholder="Software" />
      <br />
      <label for="companySize">Company Size :</label>
      <select id="companySize" name="companySize">
        <option value="1">규모 선택</option>
        <option value="2">0-1</option>
        <option value="3">2-10</option>
        <option value="4">11-50</option>
        <option value="5">51-200</option>
        <option value="6">201-500</option>
        <option value="7">501-1000</option>
        <option value="8">1001-5000</option>
        <option value="9">5001-10000</option>
        <option value="10">10000+</option>
      </select>
      <br />
      <label for="companyType">Company Type :</label>
      <select id="companyType" name="companyType">
        <option value="1">종류 선택</option>
        <option value="2">Private</option>
        <option value="3">Government</option>
        <option value="4">Nonprofit</option>
        <option value="5">Educational</option>
        <option value="6">Self-Employed</option>
        <option value="7">Partnership</option>
        <option value="8">Sole Proprietorship</option>
      </select>
      <br />
      <label for="companyExplain">Company Explain :</label>
      <textarea
        id="companyExplain"
        name="companyExplain"
        maxlength="120"
      ></textarea>
      <br />
      <label for="logo">Logo :</label>
      <input type="file" id="logo" name="logo" />
      <br />
      <button type="submit">Submit</button>
      &nbsp;
      <button type="reset">Reset</button>
    </form>
  </body>
</html>
