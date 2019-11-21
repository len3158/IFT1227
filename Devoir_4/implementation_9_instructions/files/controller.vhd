--IFT1227: Devoir 4
--Auteur: Lenny SIEMENI, Matricule: 1055234
library IEEE; use IEEE.STD_LOGIC_1164.all;
entity controller is -- single cycle control decoder
	port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
			zero: in STD_LOGIC;
			memtoreg: out STD_LOGIC_VECTOR (1 downto 0); -- modified nb bit selectors for mux4
			memwrite: out STD_LOGIC;
			pcsrc: out STD_LOGIC;
			alusrc: out STD_LOGIC_VECTOR (1 downto 0); -- modified nb bit selectors for mux4
			regdst: out STD_LOGIC_VECTOR (1 downto 0); -- modified nb bit selectors for mux4; 
			regwrite: out STD_LOGIC;
			jump: out STD_LOGIC;
			jr: out STD_LOGIC; --added this to implement jr instruction
			alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
end;

architecture struct of controller is
	component maindec
		port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4 
			memwrite, branch: out STD_LOGIC;
			alusrc: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4
			regdst: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4
			regwrite, jump: out STD_LOGIC;
			jr: out STD_LOGIC;--added this to implement jr instruction
			aluop: out STD_LOGIC_VECTOR (1 downto 0));
	end component;
	component aludec
		port (funct: in STD_LOGIC_VECTOR (5 downto 0);
				aluop: in STD_LOGIC_VECTOR (1 downto 0);
				alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
	signal aluop: STD_LOGIC_VECTOR (1 downto 0);
	signal branch: STD_LOGIC;
begin
	md: maindec port map (op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, jr, aluop);
	ad: aludec port map (funct, aluop, alucontrol);
	pcsrc <= branch and zero;
end;