#define USE_DOT 0
#define USE_CACHE 1
module mm
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
         write(*,*) "Using dot!"
#else
         write(*,*) "Not using dot!"
#endif
#if USE_CACHE
         write(*,*) "Using cache!"
#else
         write(*,*) "Not using cache!"
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
            sum = 0.d0
            multiply = 0.d0
#if USE_CACHE
            do i = 1, my! columns in mmultiply
                do j = 1, mx ! rows in multiply
    #if USE_DOT
                    multiply(i,j)=dot_product(first(i,:),second(:,j))
    #else
                    do k = 1, fx
                        sum = sum + first(i, k) * second(k, j)
                    end do
                    multiply(i, j) = sum
                    sum = 0.d0
    #endif

                end do
            end do
#else
            do ii = 1, my, ichunk
                do jj = 1, mx, ichunk
                    do i = ii, min(ii + ichunk - 1, my)! columns in mmultiply
                        do j = jj, min(jj + ichunk - 1, mx) ! rows in multiply
    #if USE_DOT
                             multiply(i,j)=dot_product(first(i,:),second(:,j))
    #else
                            do k = 1, fx
                                    sum = sum + first(i, k) * second(k, j)
                                end do
                                multiply(i, j) = sum
                                sum = 0.d0
    #endif
                        end do
                    end do
                end do
            end do
#endif
            ret = 0.d0
        ELSE
            ret = 1.d0
        END IF
    end subroutine mult
end module
