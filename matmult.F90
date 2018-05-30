#define USE_DOT 1
#define USE_CACHE 0
module mmmm
    implicit none
contains
    subroutine mult(first, second, multiply, ret)

        implicit none
        real (kind = 8), intent(in) :: first(:, :)
        real (kind = 8), intent(in) :: second(:, :)
        real (kind = 8), intent(out) :: multiply(:, :)
        integer(kind = 4) :: fxy, fx, fy, sxy, sx, sy, mx, my

        integer (kind = 4), intent(out) :: ret
        integer(kind = 4) :: i, j, k, ii, jj, ichunk
        real (kind = 8) :: sum

        ichunk = 1024

#if USE_DOT
         !write(*,*) "Using dot!"
#else
         !write(*,*) "Not using dot!"
#endif
#if USE_CACHE
         !write(*,*) "Using cache!"
#else
         !write(*,*) "Not using cache!"
#endif

        fx = SIZE(first(1, :)) !number of colums in first matrix
        fy = SIZE(first(:, 1)) !number of rows in first matrix
        fxy = SIZE(first) !number of rows and columns in first matrix
        sx = SIZE(second(1, :)) !number of colums in second matrix
        sy = SIZE(second(:, 1)) !number of rows in second matrix
        sxy = SIZE(second) !number of rows and columns in second matrix
        mx = SIZE(multiply(1, :))
        my = SIZE(multiply(:, 1))

        IF (fx == sy .AND. fx * fy == fxy .AND. sx * sy == sxy .AND. fy == my .AND. sx == mx) THEN
            multiply = MATMUL(first, second)
        ELSE
            ret = 1.d0
        END IF
    end subroutine mult
end module
