create table EmployeeDetails(
		EDID nvarchar(10) primary key, --NEDT (non-editable) 
		EDFName nvarchar(100) not null,
		EDLName nvarchar(100) not null,
		EDGender char check(EDGender='M' or EDGender='F') not null,
		EDEmail nvarchar(100) not null,
		EDMobNum nvarchar(10) not null, 
		EDDesig nvarchar(100) not null, /*WHAT THEY DO/POSITION IN THE DEPARTMENT*/
		EDDMID nvarchar(10) references DeptMaster(DMID) not null,
		EDDOJ nvarchar(10) not null,
		EDDOB nvarchar(10) not null,
		EDBldGrp nvarchar(3) check(EDBldGrp='OP' or EDBldGrp='ON' OR EDBldGrp='AP' OR EDBldGrp='AN' OR EDBldGrp='BP' OR EDBldGrp='BN' OR EDBldGrp='ABP' OR EDBldGrp='ABN'),
		EDNationlty nvarchar(100) not null,
		EDVisaSts nvarchar(100) not null,
		EDAddress nvarchar(100) not null,
		EDEmgContName nvarchar(100) not null,
		EDEmgContRel nvarchar(100) not null, /*relation like dad or mom*/
		EDEmgContNum nvarchar(20) not null,
		EDEmplSts nvarchar(100) check (EDEmplSts='Active' or EDEmplSts='InActive' or EDEmplSts='Vacation' or EDEmplSts='Emergency'),
		EDMarSts nvarchar(100) check (EDMarSts='Married' or EDMarSts='Single' or EDMarSts = 'Seperated'),
		EDNoDpn smallint not null,/*num of dependants*/
		EDCrDt datetime not null default getdate(),
		EDMbDt datetime not null default getdate()
	)	

	create table AdminDetails(
		ADSrNo int identity (1,1),
		ADEDID nvarchar(10) references EmployeeDetails(EDID) not null,
		ADPassword nvarchar(20) not null,
		ADCrDt datetime not null default getdate(), 
		ADMbDt datetime not null default getdate()
	)

	create table DeptMaster(
		DMSrNo int identity (1,1),
		DMID nvarchar(10) primary key not null,
		DMName nvarchar(100),
		DMCrDt datetime default getdate(),
		DMMbDt datetime default getdate()
	)

	alter procedure SPMarketNetLogin(
		@Email nvarchar(100), 
		@Password nvarchar(20),
		@DeptID nvarchar(10)
	)
	as 
	begin 
		Declare @eid nvarchar(10)  --empty variable
		select @eid = isnull(EDID,'') 
		from EmployeeDetails
		left join AdminDetails on EDID = ADEDID
		where EDEmail = @Email
		and ADPassword = @Password
		and ADEDID = @DeptID
		select @eid;
	end

	select * from AdminDetails WHERE ADEDID = ADEDID AND ADPassword = ADPassword;
	exec SPMarketNetLogin @DeptID = ADEDID , @Password = ADPassword, @Email = EDEmail;


	alter procedure SPGetEmpDtls
		@EmpID nvarchar(10),   
		@DeptID nvarchar(10)	
	as
	begin
	--declare @EmpID nvarchar(10),@DeptID nvarchar(10)	   
		select EDID 'EID', EDFName'First Name',EDLName'Last Name',EDGender'Gender',EDEmail'Email',EDMobNum'Mobile',EDDesig 'Designation',EDDMID 'Dept ID',EDDOJ'Join Date',EDDOB 'Birth Date',
			EDBldGrp'Blood Group',EDNationlty'Nationality',EDVisaSts'Visa Status',EDAddress'Address',EDEmgContName'Emg Contact Name',EDEmgContRel'Emg Contact Relationship',
			EDEmgContNum'Emg Contact Number',EDEmplSts'Employee Status',EDMarSts'Marital Status',EDNoDpn'Dependents'
	from EmployeeDetails
		where EDID = @EmpID
		and EDDMID = @DeptID
	end	
	exec SPGetEmpDtls @EmpID = 'E001', @DeptID = 'HR001';

	alter procedure SPUpdtEmpDtls(
		  @EDID nvarchar(10),
		  @EDFName nvarchar(100),
		  @EDLName nvarchar(100),
		  @EDGender char(1),
		  @EDEmail nvarchar(100),
		  @EDMobNum nvarchar(10),
		  --@EDDesig nvarchar(100),
		  @EDDMID nvarchar(10),
		  --@EDDOJ nvarchar(10),
		  --@EDDOB nvarchar(10),
		  --@EDBldGrp nvarchar(3),
		  --@EDNationlty nvarchar(100),
		  @EDVisaSts nvarchar(100),
		  @EDAddress nvarchar(100),
		  --@EDEmgContName nvarchar(100),
		  --@EDEmgContRel nvarchar(100),
		  --@EDEmgContNum nvarchar(20),
		  @EDEmplSts nvarchar(100)
		  --@EDMarSts nvarchar(100),
		  --@EDNoDpn smallint
	)
	as 
	begin
		update EmployeeDetails
		set 
			[EDFName] = @EDFName,
			[EDLName] = @EDLName,
			[EDGender] = @EDGender,
		    [EDEmail] = @EDEmail, 
			[EDMobNum] = @EDMobNum, 
			--[EDDesig] = @EDDesig,
			[EDDMID] = @EDDMID, 
			--[EDDOJ] = @EDDOJ, 
			--[EDDOB] = @EDDOB,
			--[EDBldGrp] = @EDBldGrp,
			--[EDNationlty] = @EDNationlty, 
			[EDVisaSts] = @EDVisaSts,
			[EDAddress] = @EDAddress,
			--[EDEmgContName] = @EDEmgContName, 
			--[EDEmgContRel] = @EDEmgContRel,
			--[EDEmgContNum] = @EDEmgContNum, 
			[EDEmplSts] = @EDEmplSts,
			--[EDMarSts] = @EDMarSts, 
			--[EDNoDpn] = @EDNoDpn, 
			[EDMbDt] = getdate()
		WHERE EDID = @EDID
	select @@ROWCOUNT
	end
	exec SPUpdtEmpDtls;

		insert into EmployeeDetails(EDID, EDFName, EDLName, EDGender, EDEmail, EDMobNum, EDDesig, EDDMID, EDDOJ, EDDOB, EDBldGrp, EDNationlty, EDVisaSts, EDAddress, EDEmgContName, EDEmgContRel, EDEmgContNum, EDEmplSts, EDMarSts, EDNoDpn, EDCrDt, EDMbDt)
		values
				--('E001', 'John', 'Doe', 'M', 'john.doe@marketnet.com', '1234567890', 'Developer', 'HR001', '2023-01-01', '1990-01-01', 'OP', 'US', 'Employed', '123 Main Street', 'Jane Doe', 'Spouse', '9876543210', 'Active', 'Married', 2, getdate(),getdate()),
				--('E002', 'Jane', 'Smith', 'F', 'jane.smith@marketnet.com', '9876543210', 'Manager', 'MK002', '2023-01-02', '1985-02-15', 'ON', 'UK', 'Employed', '456 Elm Street', 'John Smith', 'Spouse', '1234567890', 'Active', 'Married', 1, getdate(),getdate()),
				--('E003', 'David', 'Johnson', 'M', 'david.johnson@marketnet.com', '5555555555', 'Analyst', 'HR001', '2023-01-03', '1992-03-20', 'AP', 'Canada', 'Employed', '789 Oak Street', 'Sarah Johnson', 'Spouse', '5555555555', 'InActive', 'Married', 3, getdate(),getdate()),
				--('E004', 'Sarah', 'Williams', 'F', 'sarah.williams@marketnet.com', '6666666666', 'Designer', 'MK002', '2023-01-04', '1988-04-25', 'AN', 'Australia', 'Employed', '321 Pine Street', 'David Williams', 'Spouse', '6666666666', 'Active', 'Married', 0, getdate(),getdate()),
				--('E005', 'Michael', 'Brown', 'M', 'michael.brown@marketnet.com', '7777777777', 'Engineer', 'HR001', '2023-01-05', '1995-05-30', 'BP', 'Germany', 'Employed', '987 Cedar Street', 'Emily Brown', 'Sister', '7777777777', 'Active', 'Single', 1, getdate(),getdate()),
				--('E006', 'Ahmed', 'Khan', 'M', 'ahmed.khan@marketnet.com', '8888888888', 'Architect', 'MK002', '2023-01-06', '1980-06-10', 'BN', 'Pakistan', 'Employed', '654 Birch Street', 'Fatima Khan', 'Spouse', '8888888888', 'Active', 'Married', 2, getdate(),getdate()),
				--('E007', 'Maria', 'Garcia', 'F', 'maria.garcia@marketnet.com', '9999999999', 'Coordinator', 'HR001', '2023-01-07', '1993-07-15', 'ABP', 'Spain', 'Employed', '123 Walnut Street', 'Carlos Garcia', 'Spouse', '9999999999', 'Vacation', 'Married', 1, getdate(),getdate()),
				('E008', 'Lei', 'Chen', 'M', 'lei.chen@marketnet.com', '1111111111', 'Consultant', 'MK002', '2023-01-08', '1986-08-20', 'ABN', 'China', 'Employed', '456 Maple Street', 'Yan Chen', 'Spouse', '1111111111', 'Emergency', 'Married', 0, getdate(),getdate());

		insert into DeptMaster(DMID, DMName, DMCrDt, DMMbDt)
		values	('HR001','Human Resources', getdate(),getdate()),
				('MK002','Marketing', getdate(),getdate())

		insert into AdminDetails(ADEDID,ADPassword,ADCrDt,ADMbDt)
		values	('E001','admin@hr', getdate(),getdate()),
				('E002','admin@mk', getdate(),getdate())

	--make departments names
	--COMMANDS
	DROP PROCEDURE SPMarketNetLogin;
	drop table EmployeeDetails
	drop table AdminDetails
	drop table DeptMaster
	select * from EmployeeDetails;
	select * from AdminDetails;
	select * from DeptMaster;
	delete from EmployeeDetails where EDID = 'E008';
