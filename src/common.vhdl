library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common is
    -- operations of fpu
    constant FPU_OP_ADD         : std_logic_vector(1 downto 0) := "00";
    constant FPU_OP_SUB         : std_logic_vector(1 downto 0) := "01";
    constant FPU_OP_MUL         : std_logic_vector(1 downto 0) := "10";
    constant FPU_OP_DIV         : std_logic_vector(1 downto 0) := "11";

    -- modes of fpu
    constant FPU_MODE_FXD       : std_logic_vector(1 downto 0) := "00";
    constant FPU_MODE_F64       : std_logic_vector(1 downto 0) := "01";
    constant FPU_MODE_F32       : std_logic_vector(1 downto 0) := "10";

    -- major states
    constant STATE_LOAD         : std_logic_vector(1 downto 0) := "00";
    constant STATE_WAIT         : std_logic_vector(1 downto 0) := "01";
    constant STATE_PROC         : std_logic_vector(1 downto 0) := "10";
    constant STATE_OUT          : std_logic_vector(1 downto 0) := "11";

    -- operations constants
    constant FIXED_SCALE_FACTOR : integer                      := 7;

    function to_vec(i : integer; size : integer                := 16) return std_logic_vector;
    function to_vec(i : std_logic; size : integer              := 16) return std_logic_vector;
    function to_vec(i : std_logic_vector; size : integer       := 16) return std_logic_vector;
    function to_int(i           : std_logic_vector) return integer;
    function to_string(a        : std_logic_vector) return string;
end package;

package body common is
    function to_vec(i : integer; size : integer := 16) return std_logic_vector is
        variable tmp : unsigned(size - 1 downto 0);
    begin
        if i < 0 then
            tmp := to_unsigned(-i, size);
            tmp := not tmp;
            tmp := tmp + 1;
        else
            tmp := to_unsigned(i, size);
        end if;

        return std_logic_vector(tmp);
    end function;

    function to_vec(i : std_logic; size : integer := 16) return std_logic_vector is
        variable v : std_logic_vector(size - 1 downto 0);
    begin
        v := (others => i);
        return v;
    end function;

    function to_vec(i : std_logic_vector; size : integer := 16) return std_logic_vector is
        variable v : std_logic_vector(size - 1 downto 0)     := i;
    begin
        return v;
    end function;

    function to_string(a : std_logic_vector) return string is
        variable b           : string (1 to a'length) := (others => NUL);
        variable stri        : integer                := 1;
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
            stri    := stri + 1;
        end loop;

        return b;
    end function;

    function to_int(i : std_logic_vector) return integer is
    begin
        return to_integer(unsigned(i));
    end function;
end package body;