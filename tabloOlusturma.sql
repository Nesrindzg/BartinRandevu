CREATE TABLE [tblPoliklinik](
	[poliklinikID] [int] IDENTITY(1,1) NOT NULL,
	[poliklinikAdi] [varchar](50) NULL,
	PRIMARY KEY([poliklinikID]))

CREATE TABLE [tblHasta](
	[hastaID] [int] IDENTITY(1,1) NOT NULL,
	[hastaAdi] [varchar](25) NULL,
	[hastaSoyadi] [varchar](25) NULL,
	[hastaCinsiyeti] [varchar](5) NULL,
	[hastaTC] [varchar](11) NULL,
	[hastaDTarihi] [date] NULL,
	[hastaTel] [varchar](11) NULL,
	[hastaMail] [varchar](50) NULL,
	[hastaSifre] [varchar](50) NULL,
	PRIMARY KEY([hastaID]))

CREATE TABLE [dbo].[tblDoktor](
	[doktorID] [int] IDENTITY(1,1) NOT NULL,
	[doktorAdi] [varchar](50) NULL,
	[doktorSoyadi] [varchar](50) NULL,
	[poliklinikNo] [int] NULL,
	PRIMARY KEY([doktorID]),

	FOREIGN KEY([poliklinikNo]) REFERENCES [tblPoliklinik] ([poliklinikID])
		ON UPDATE CASCADE ON DELETE CASCADE)

CREATE TABLE [tblRandevu](
	[randevuID] [int] IDENTITY(1,1) NOT NULL,
	[hastaNo] [int] NULL,
	[doktorNo] [int] NULL,
	[randevuTarihi] [date] NULL,
	[randevuSaati] [time](4) NULL,

	PRIMARY KEY ([randevuID]),

	FOREIGN KEY([doktorNo]) REFERENCES [tblDoktor] ([doktorID])
		ON UPDATE CASCADE ON DELETE CASCADE,
	
	FOREIGN KEY([hastaNo]) REFERENCES [tblHasta] ([hastaID])
		ON UPDATE CASCADE ON DELETE CASCADE)