module mm
    implicit none
contains
    subroutine mult(first, second, multiply, ret)
        implicit none
        real (kind = 8), intent(in) :: first(:, :)
        real (kind = 8), intent(in) :: second(:, :)
        real (kind = 8), intent(out) :: multiply(:, :)
        integer(kind = 4) :: fxy, fx, fy, sxy, sx, sy, mxy, mx, my

        integer (kind = 4), intent(out) :: ret
        integer(kind = 4) :: i, j, k
        real (kind = 8) :: sum

        fx = SIZE(first(1, :)) !number of colums in first matrix
        fy = SIZE(first(:, 1)) !number of rows in first matrix
        fxy = SIZE(first) !number of rows and columns in first matrix
        sx = SIZE(second(1, :)) !number of colums in second matrix
        sy = SIZE(second(:, 1)) !number of rows in second matrix
        sxy = SIZE(second) !number of rows and columns in second matrix
        mx = SIZE(multiply(1, :))
        my = SIZE(multiply(:, 1))
        mxy = SIZE(multiply)

        IF (fx == sy .AND. fx * fy == fxy .AND. sx * sy == sxy .AND. fy == my .AND. sx == mx) THEN
            sum = 0.d0
            multiply = 0.d0

            do i = 1, my! columns in mmultiply
                do j = 1, mx ! rows in multiply
                    do k = 1, fx
                        sum = sum + first(i, k) * second(k, j)
                    end do
                    multiply(i, j) = sum
                    sum = 0.d0
                end do
            end do
            ret = 0.d0
        ELSE
            ret = 1.d0
        END IF
    end subroutine mult
end module
