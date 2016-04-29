function v = haar_2d ( u )

%  Parameters:
%  Input, real U(M,N), the vector to be transformed.
%  Output, real V(M,N), the transformed vector.

[ m, n ] = size ( u );
v = u;
s = sqrt ( 2.0 );
w = zeros ( m, n );

%%  Determine K, the largest power of 2 such that K <= M
k = 1;
while ( k * 2 <= m )
    k = k * 2;
end

%%  Transform all columns.
while ( 1 < k )
    k = floor ( k / 2 );
    w(  1:  k,:) = ( v(1:2:2*k-1,:) + v(2:2:2*k,:) ) / s;
    w(k+1:k+k,:) = ( v(1:2:2*k-1,:) - v(2:2:2*k,:) ) / s;
    v(1:2*k,:) = w(1:2*k,:);
end

%%  Determine K, the largest power of 2 such that K <= N.
k = 1;
while ( k * 2 <= n )
    k = k * 2;
end

%  Transform all rows.
while ( 1 < k )
    k = floor ( k / 2 );
    w(:,  1:  k) = ( v(:,1:2:2*k-1) + v(:,2:2:2*k) ) / s;
    w(:,k+1:k+k) = ( v(:,1:2:2*k-1) - v(:,2:2:2*k) ) / s;
    v(:,1:2*k) = w(:,1:2*k);
end
return
end