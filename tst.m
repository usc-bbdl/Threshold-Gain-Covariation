protocol_channel=data(:,2);

start_index=find(protocol_channel==-1000)
number_of_runs=length(start_index)

protocols_allruns=zeros(9,number_of_runs);

if number_of_runs==0
    error('There is no run indicator ssignal (-1000) on the protocol channel')
else
    for i=1:number_of_runs
        protocols_allruns(:,i)=protocol_channel(start_index(i):start_index(i)+8);
    end
end

gamma_d_1_all=protocols_allruns(2,:);
gamma_d_1=sort(unique(gamma_d_1_all)); %unique_and_sorted
gamma_s_1_all=protocols_allruns(3,:);
gamma_s_1=sort(unique(gamma_s_1_all)); %unique_and_sorted
cortex_1_all=protocols_allruns(4,:);
cortex_1=sort(unique(cortex_1_all)); %unique_and_sorted
gamma_d_2_all=protocols_allruns(5,:);
gamma_d_2=sort(unique(gamma_d_2_all)); %unique_and_sorted
gamma_s_2_all=protocols_allruns(6,:);
gamma_s_2=sort(unique(gamma_s_2_all)); %unique_and_sorted
cortex_2_all=protocols_allruns(7,:);
cortex_2=sort(unique(cortex_2_all)); %unique_and_sorted
pos_all=protocols_allruns(8,:);
pos=sort(unique(pos_all)); %unique_and_sorted
vel_all=protocols_allruns(9,:);
vel=sort(unique(vel_all)); %unique_and_sorted